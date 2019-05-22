//...

/** This implements the "h" term used in the equations described in section 4.5 of the
 paper. Three arguments are needed:
 1. projection_plane_normal: We need to know where the projection plane is in 3-space
    Since a plane can be defined by a point within the plane and a normal, we use
    this normal together with the 3rd argument to the function to define the projection
    plane described in the paper.
 2. silhouette_curve: As described in the paper, the silhouette curve is a 3D version
    of the curve the user draws with the mouse.  It is formed by projecting the
    original 2D screen-space curve onto the 3D projection plane.
 3. closest_pt_in_plane: As described in the paper, this is the closest point within
    the projection plane to the vertex of the mesh that we want to modify.  In other
    words, it is the perpendicular projection of the vertex we want to modify onto
    the projection plane.
 */
float hfunc(const Vector3 projection_plane_normal, const std::vector<Point3> &silhouette_curve, const Point3 &closest_pt_in_plane) {
    // define the y axis for a "plane space" coordinate system as a world space vector
    Vector3 plane_y = Vector3(0,1,0);
    // define the x axis for a "plane space" coordinate system as a world space vector
    Vector3 plane_x = plane_y.Cross(projection_plane_normal).ToUnit();
    // define the origin for a "plane space" coordinate system as the first point in the curve
    Point3 origin = silhouette_curve[0];
    
    // loop over line segments in the curve, find the one that lies over the point by
    // comparing the "plane space" x value for the start and end of the line segment
    // to the "plane space" x value for the closest point to the vertex that lies
    // in the projection plane.
    float x_target = (closest_pt_in_plane - origin).Dot(plane_x);
    for (int i=1; i<silhouette_curve.size(); i++) {
        float x_start = (silhouette_curve[i-1] - origin).Dot(plane_x);
        float x_end = (silhouette_curve[i] - origin).Dot(plane_x);
        if ((x_start <= x_target) && (x_target <= x_end)) {
            float alpha = (x_target - x_start) / (x_end - x_start);
            float y_curve = silhouette_curve[i-1][1] + alpha*(silhouette_curve[i][1] - silhouette_curve[i-1][1]);
            return y_curve - closest_pt_in_plane[1];
        }
        else if ((x_end <= x_target) && (x_target <= x_start)) {
            float alpha = (x_target - x_end) / (x_start - x_end);
            float y_curve = silhouette_curve[i][1] + alpha*(silhouette_curve[i-1][1] - silhouette_curve[i][1]);
            return y_curve - closest_pt_in_plane[1];
        }
    }
    
    // here return 0 because the point does not lie under the curve.
    return 0.0;
}

/// Modifies the vertices of the ground mesh to create a hill or valley based
/// on the input stroke.  The 2D path of the stroke on the screen is passed
/// in, this is the centerline of the stroke mesh that is actually drawn on
/// the screen while the user is drawing.
void Ground::ReshapeGround(const Matrix4 &view_matrix, const Matrix4 &proj_matrix,
                           const std::vector<Point2> &stroke2d)
{
    // Deform the 3D ground mesh according to the algorithm described in the
    // Cohen et al. Harold paper.
    // You might need the eye point and the look vector, these can be determined
    // from the view matrix as follows:
    Matrix4 camera_matrix = view_matrix.Inverse();
    Point3 eye = camera_matrix.ColumnToPoint3(3);
    Vector3 look = -camera_matrix.ColumnToVector3(2);
    
    // There are 3 major steps to the algorithm, outlined here:
    
    // 1. Define a plane to project the stroke onto.  The first and last points
    // of the stroke are guaranteed to project onto the ground plane.  The plane
    // should pass through these two points on the ground.  The plane should also
    // have a normal vector that points toward the camera and is parallel to the
    // ground plane.
    Point3 start;
    
    Point3 end;
    ScreenPtToGround(view_matrix, proj_matrix, stroke2d.front(), &start);
    ScreenPtToGround(view_matrix, proj_matrix, stroke2d.back(), &end);
    Vector3 start_to_end = (start - end).ToUnit();
    Vector3 plane_normal = -start_to_end.Cross(Vector3(0,1,0)).ToUnit();
    
    // 2. Project the 2D stroke into 3D so that it lies on the "projection plane"
    // defined in step 1.
    std::vector<Point3> stroke_to_3d;
    for (int i = 0; i<stroke2d.size(); i++){
        Point3 pt3d = GfxMath::ScreenToNearPlane(view_matrix, proj_matrix, stroke2d[i]);
        Ray ray(eye, (pt3d - eye).ToUnit());
        float i_time;
        Point3 i_point;
        ray.IntersectPlane	(start, plane_normal, &i_time, &i_point);
        stroke_to_3d.push_back(i_point);
    }
    
    // 3. Loop through all of the vertices of the ground mesh, and adjust the
    // height of each based on the equations in section 4.5 of the paper, also
    // repeated in the assignment handout.  The equations rely upon a function
    // h(), and we have implemented that for you as hfunc() defined above in
    // this file.  The basic structure of the loop you will need is here:
    std::vector<Point3> new_verts;
    for (int i=0; i<ground_mesh_.num_vertices(); i++) {
        Point3 P = ground_mesh_.vertex(i); // original vertex
        
        // adjust P according to equations...
        float h = hfunc(plane_normal, stroke_to_3d, P.ClosestPointOnPlane(start, plane_normal));
        
        if(h != 0.0){
            float d = P.DistanceToPlane(start, plane_normal);
            float t = 1-pow(d/5,2);
            float w = fmax(0.0, t);
            P = Point3(P[0], (1-w)*P[1]+(w*h), P[2]);
        }  
        new_verts.push_back(P);
    }
    ground_mesh_.SetVertices(new_verts);
    ground_mesh_.CalcPerVertexNormals();
    ground_mesh_.UpdateGPUMemory();
    ground_edge_mesh_.CreateFromMesh(ground_mesh_);
}

//...