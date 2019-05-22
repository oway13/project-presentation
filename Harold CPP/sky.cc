//...

/// Projects a 2D normalized screen point (e.g., the mouse position in normalized
/// device coordinates) to a 3D point on the "sky", which is really a huge sphere
/// (radius = 1500) that the viewer is inside.  This function should always return
/// true since any screen point can successfully be projected onto the sphere.
/// sky_point is set to the resulting 3D point.  Note, this function only checks
/// to see if the ray passing through the screen point intersects the sphere; it
/// does not check to see if the ray hits the ground or anything else first.
bool Sky::ScreenPtToSky(const Matrix4 &view_matrix, const Matrix4 &proj_matrix,
                        const Point2 &normalized_screen_pt, Point3 *sky_point)
{
    Matrix4 camera_matrix = view_matrix.Inverse();
    Point3 eye = camera_matrix.ColumnToPoint3(3);
    
    Point3 pt3d = GfxMath::ScreenToNearPlane(view_matrix, proj_matrix, normalized_screen_pt);
    Ray ray(eye, (pt3d - eye).ToUnit());
    float t;
    return ray.IntersectSphere(Point3::Origin(), 1500.0, &t, sky_point);
}

/// Creates a new sky stroke mesh by projecting each vertex of the 2D mesh
/// onto the sky dome and saving the result as a new 3D mesh.
void Sky::AddSkyStroke(const Matrix4 &view_matrix, const Matrix4 &proj_matrix,
                       const Mesh &stroke2d_mesh, const Color &stroke_color)
{
    Mesh m = stroke2d_mesh;
    struct SkyStroke new_stroke; 
    std::vector<Point3> newpoints;
    Point3 new_s;
    for(int i  = 0; i < m.num_vertices(); i++){
        ScreenPtToSky(view_matrix, proj_matrix, Point2(m.vertex(i)[0], m.vertex(i)[1]), &new_s);
        newpoints.push_back(new_s);
    }
    m.SetVertices(newpoints);
    new_stroke.mesh = m;
    new_stroke.color = stroke_color;
    strokes_.push_back(new_stroke);

}

//...

