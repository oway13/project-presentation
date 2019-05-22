

var addthis_config = {
          services_compact: 'email, facebook, twitter, more',
          services_exclude: 'print'
}

var VacanciesAreOnThisPage = true

//window.onerror = function nada(){}

function centerWin(zwidth,zheight){
       var winHeight
       var winWidth
       winHeight = screen.availHeight
       winWidth = screen.width
       if (zwidth > winWidth){zwidth=winWidth}
       if (zheight > winHeight){zheight=winHeight}
       zleft = parseInt((winWidth/2)-(zwidth/2))
       if (zleft < 10){zleft = 0}
       ztop = parseInt((winHeight/2)-(zheight/2))
       if (ztop < 25){ztop = 0}
       var x = "width=" + zwidth + ",height=" + zheight + ",left=" + zleft + ",top=" + ztop
       return x
}

function applyFor(posJobCode,posFirstChoice,posSpecialty){
       var openwindow = false
       if (document.layers){
              alert("Please go back and then click 'Start an Application' to apply for this position.")
              return false;
       }
       var OpenWin = true
       try {
              if (typeof self.opener.updateApp == "boolean"){
                     OpenWin = false
              }
       } catch (e) {
              OpenWin = true
       }

       if (OpenWin){
              var applyFor = window.open("https://www.applitrack.com/ndus/onlineapp/_application.aspx?posJobCodes=" + posJobCode + "&posFirstChoice=" + posFirstChoice + "&posSpecialty=" + posSpecialty + "","applyFor","location=no,resizable=yes,scrollbars=yes," + centerWin(795,550))
              applyFor.focus()
       } else {
              window.opener.location = "javascript: applyFor('" + posJobCode + "','" + posFirstChoice + "','" + posSpecialty + "')"
              self.close()
       }
}

function oldWay(){
       var openwindow = false
       if (document.layers){
              alert("Please go back and then click 'Start an Application' to apply for this position.")
              return false;
       }
       if (opener == null){
              var applyFor = window.open("https://www.applitrack.com/ndus/onlineapp/_application.aspx?posJobCodes=" + posJobCode + "&posFirstChoice=" + posFirstChoice + "&posSpecialty=" + posSpecialty + "","applyFor","location=no,resizable=yes,scrollbars=yes," + centerWin(795,550))
              applyFor.focus()
       }else{
              if (typeof self.opener == "undefined"){
                     var applyFor = window.open("https://www.applitrack.com/ndus/onlineapp/_application.aspx?posJobCodes=" + posJobCode + "&posFirstChoice=" + posFirstChoice + "&posSpecialty=" + posSpecialty + "","applyFor","location=no,resizable=yes,scrollbars=yes," + centerWin(795,550))
                     applyFor.focus()
              }else{
                     if (typeof self.opener.updateApp == "boolean"){
                           window.opener.location = "javascript: applyFor('" + posJobCode + "','" + posFirstChoice + "','" + posSpecialty + "')"
                           self.close()
                     }else{
                           var applyFor = window.open("https://www.applitrack.com/ndus/onlineapp/_application.aspx?posJobCodes=" + posJobCode + "&posFirstChoice=" + posFirstChoice + "&posSpecialty=" + posSpecialty + "","applyFor","location=no,resizable=yes,scrollbars=yes," + centerWin(795,550))
                           applyFor.focus()
                     }
              }
       }
}
function applyForInternal(posJobCode,posFirstChoice,posSpecialty){
    var passDistrictCode;

       var applyFor = window.open("https://www.applitrack.com/ndus/onlineapp/_application.aspx?isInternal=1&posJobCodes=" + posJobCode + "&posFirstChoice=" + posFirstChoice + "&posSpecialty=" + posSpecialty + passDistrictCode + "","applyFor","location=no,resizable=yes,scrollbars=yes," + centerWin(795,550))
       applyFor.focus()
}

function applyForOutsideDistrict(district,posJobCode,posFirstChoice,posSpecialty){
    var applyPage;
    var applyWinSize;
    
        applyPage = '_application.aspx';
    
       var applyFor = window.open("https://www.applitrack.com/" + district + "/onlineapp/" + applyPage + "?posJobCodes=" + posJobCode + "&posFirstChoice=" + posFirstChoice + "&posSpecialty=" + posSpecialty + "","applyFor","location=no,resizable=yes,scrollbars=yes," + centerWin(795,550))
       applyFor.focus()
}

function toggle_block(i) {
       if (AppliTrack_$(i).style.display == 'none'){ AppliTrack_$(i).style.display = 'block';} else {AppliTrack_$(i).style.display = 'none';}
       setUpPageBreaks()
       return false;
}

function submitAppliTrackSearch(){
       AppliTrack_SearchExecute(null);
}

/* Deprecated; use AppliTrack_SearchExecute() */
function AppliTrackSort(key){
       winLoc = window.location.toString()
       if (window.location.search == "") {
              window.location = winLoc + "?AppliTrackSort=" + escape(key)
       }else{
              if (window.location.search.indexOf("AppliTrackSort=") > 0){
                     var currLoc = winLoc.substring(0,winLoc.indexOf("AppliTrackSort="))
                     window.location = winLoc.replace(/([^a-zA-Z0-9\-\.]+AppliTrackSort=)([a-zA-Z0-9\-\.]+)([&a-zA-Z0-9\-\.]*)/i,'$1' + escape(key) + '$3');
              }else{
                     window.location = winLoc + (winLoc.indexOf("?") < 0?"?":"&") + "AppliTrackSort=" + escape(key)
              }
       }
}

function AppliTrackSearchFocus(){
    var e = AppliTrack_$('AppliTrackPostingSearchBasic');
       if (e && e.value == "Search Postings"){
              e.value = ""
              e.style.color = "black"
              e.style.fontStyle = "normal"
       }
}
function AppliTrackSearchBlur(){
    var e = AppliTrack_$('AppliTrackPostingSearchBasic');
       if (e && e.value == ""){
              e.value = "Search Postings"
              e.style.color = "#999999"
              e.style.fontStyle = "italic"
       }
}
function AppliTrack_WatchForEnter(e){
       if(window.event)
        key = window.event.keyCode;     //IE
    else
        key = e.which;     //firefox

    if (key == 13)
    {
              AppliTrack_SearchExecute(null);

              if(window.event){
                  window.event.cancelBubble = true;
                  window.event.returnValue = false;
              }

              if (event && event.stopPropagation) {
            event.stopPropagation();
        }
        if (event && event.preventDefault) {
            event.preventDefault();
        }
        return false;
    }
}

function AppliTrackInit(){
       try{
           var sf = AppliTrack_$('AppliTrackPostingSearchBasic');
           var sc = AppliTrack_$('AppliTrackSearchSubCategory');
           if(sf){sf.value = "Search Postings"}
           if(sc){sc.disabled = true;}
           if (window.location.search.indexOf("category") > 0 || window.location.search.indexOf("AppliTrackPostingSearchBasic") > 0){
                  AppliTrack_$('AppliTrackPostings').scrollIntoView(true)
           }
       }
    catch(e){}
}
setTimeout('AppliTrackInit()',100)
function AppliTrack_ToggleAdvancedSearch(){
    var hc = AppliTrack_$('AppliTrackSearchAdvancedHeaderCollapsed');
    var he=AppliTrack_$('AppliTrackSearchAdvancedHeaderExpanded');
    var c=AppliTrack_$('AppliTrackSearchAdvancedContainer');
    var s=AppliTrack_$('AppliTrackSearchSimpleContainer');
    if(!hc||!he||!c) return;
    if(hc.style.display=='block'){
        hc.style.display='none';
        he.style.display='block';
        c.style.display='block';
        s.style.opacity='.5';
        s.style.filter='alpha(opacity=50)';
    }
    else{
        hc.style.display='block';
        he.style.display='none';
        c.style.display='none';
        s.style.opacity='1';
        s.style.filter='alpha(opacity=100)';
    }
}

function AppliTrack_onKeyPressToggle(e){
    if(window.event) {
        key = window.event.keyCode;     //IE
    } else {
        key = e.which;     //firefox
    }
    //toggle advanced settings on 'enter' and 'space' keypress
    if (key == 13 || key == 32) {
        AppliTrack_ToggleAdvancedSearch();
    }
}

function AppliTrack_SearchCategorySelect(){
    var c = AppliTrack_$('AppliTrackSearchCategory');
    var sc=AppliTrack_$('AppliTrackSearchSubCategory');
    if(!c||!sc){return;}
    if(c.options&&c.selectedIndex > 0){
        sc.disabled=false;
        var v = c.options[c.selectedIndex].value;
        if(v!=''){
            try{
                eval('var g = '+v);
                sc.options.length = 0;
                sc.options[sc.options.length] = new Option('All ' + g.id + ' postings','');

                for(var i=0;i < g.vals.length;i++){
                    if(g.vals[i]==''){
                        sc.options[sc.options.length] = new Option('All ' + g.id + ' postings','');
                    }
                    else{
                        sc.options[sc.options.length] = new Option(g.vals[i],g.vals[i]);
                    }
                }
            }catch(e){/*malformed option*/}
        }
    }
    else{
        sc.options.length = 0;
        sc.disabled = true;
    }

}

function AppliTrack_RadiusSelect(){
    var l = AppliTrack_$('AppliTrackSearchLocation');
    var sr=AppliTrack_$('AppliTrackSearchRadius');
    var zct=AppliTrack_$('AppliTrackZipCode');
    var zcv = AppliTrack_$('AppliTrackZipValidator');
     if(!l||!sr){return;}
      if(l.options[l.selectedIndex].value != ''){
        sr.disabled = true;
        zct.disabled = true;
        zcv.style.visibility='hidden';
        }
        else
        {
          sr.disabled = false;
          zct.disabled = false;
        }
}


function AppliTrack_SearchExecute(f /*,execute search, default advanced form visible*/){

  var ll = AppliTrack_$('AppliTrackSearchLocation');
  var zct = AppliTrack_$('AppliTrackZipCode');
  var zcv = AppliTrack_$('AppliTrackZipValidator');
  var sbb = AppliTrack_$('AppliTrackPostingSearchBasic');
  var validateZip =true;
  if (zct !=null) {
    if (zct.value != '' ){
        validateZip =  /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(zct.value);
    }
    else
    {
        validateZip = true;
    }
  }
  else
  {
    validateZip = true;
  }


  if(( sbb.value !='Search Postings') || validateZip ){
    var loc = window.location.search;
       if(loc.substring(0,1) == '?'){
        //always replace the current search - refactor this to eliminate compounding searching
           loc = 'all=1';
        //loc= loc.substring(1,loc.length);
       }
       if(f&&(f.tagName+'').toLowerCase()=='form')
       { f.onSubmit = null; }

       if(!arguments||arguments.length<2||arguments[1]){
           //search
        var k = AppliTrack_$('AppliTrackPostingSearchBasic');
        var ak= AppliTrack_$('AppliTrackSearchKeyword');
        var tt= AppliTrack_$('AppliTrackSearchTitle');
        var d = AppliTrack_$('AppliTrackSearchDistrict');
        var l = AppliTrack_$('AppliTrackSearchLocation');
        var c = AppliTrack_$('AppliTrackSearchCategory');
        var sc= AppliTrack_$('AppliTrackSearchSubCategory');
        var pd= AppliTrack_$('AppliTrackSearchPostDateRange');
        var sregion = AppliTrack_$('AppliTrackSearchRegion');
        var zc =AppliTrack_$('AppliTrackZipCode');
        var zipr = AppliTrack_$('AppliTrackSearchRadius');
        var int = AppliTrack_$('internal');
        var state= AppliTrack_$('AppliTrackSearchState');

           var s = '';
           if(!AppliTrack_isEmpty(k)&&'Search Postings'!=''+k.value){s+=(s!=''?' ':'') + 'title:' + k.value;}
           if(!AppliTrack_isEmpty(ak)){s+=(s!=''?' ':'') + ak.value;}
           if(d&&d.options&&d.selectedIndex>=0&&''!=''+d.options[d.selectedIndex].value){
               for(var i=1;i < d.options.length;i++){
                   if(d.options[i].selected && d.options[i].value+''!=''){
                       s+=(s!=''?' ':'') + 'district:' + d.options[i].value;
                   }
               }
               loc = AppliTrack_RemoveParam(loc,'district');
           }
        var radius='';
        if (zipr != null)
        {
            if (zipr.value !='')
            {
            radius=' radius%3A"'+ zipr.value +'"';
            }
        }
        if (l != null)
        {
               if(l&&l.options&&''!=''+l.options[l.selectedIndex].value){
                   s+=(s!=''?' ':'') + 'location:"' + l.options[l.selectedIndex].value + '"';
                   loc = AppliTrack_RemoveParam(loc,'location');
               }
        }
           if(tt&&''!=''+tt.value){
               s+=(s!=''?' ':'') + 'title:"' + tt.value + '"';
               loc = AppliTrack_RemoveParam(loc,'title');
           }
        if(pd&&pd.options&&''!=''+pd.options[pd.selectedIndex].value){
               s+=(s!=''?' ':'') + 'dateposted:' + pd.options[pd.selectedIndex].value + '';
               loc = AppliTrack_RemoveParam(loc,'dateposted');
           }
           if(c&&c.options&&''!=''+c.options[c.selectedIndex].value){
            try{
                eval('var g = '+c.options[c.selectedIndex].value);
                s+=(s!=''?' ':'') + 'category:"' + g.id + '"';
                loc = AppliTrack_RemoveParam(loc,'category');
            }catch(e){/*malformed option*/}
           }

           if(sregion && sregion.options && sregion.options[sregion.selectedIndex] != null && ''!=''+sregion.options[sregion.selectedIndex].text){
                try{
                    s+=(s!=''?' ':'') + 'region:"' + sregion.options[sregion.selectedIndex].text + '"';
                    loc = AppliTrack_RemoveParam(loc,'region');
                }catch(e){/*malformed option*/}
           }

           if(sc&&sc.options&&!sc.disabled&&sc.selectedIndex>=0&&'' != ''+sc.options[sc.selectedIndex].value){
               s+=(s!=''?' ':'') + 'subcategory:"' + sc.options[sc.selectedIndex].value + '"';
               loc = AppliTrack_RemoveParam(loc,'subcategory');
           }

           if (typeof CustomSearchFormExtender == 'function') {
               s = s + CustomSearchFormExtender();
           }
           loc = AppliTrack_AddParam(loc,'AppliTrackPostingSearch',s);
       }
    if (zc != null){
        loc = AppliTrack_AddParam(loc,'AppliTrackZipCode', zc.value);
        loc = AppliTrack_AddParam(loc,'AppliTrackZipRadius', zipr.value);
    }
    if (state != null){
        loc = AppliTrack_AddParam(loc,'AppliTrackSearchState', state.value);
    }
    if (int != null)
    {
        loc = AppliTrack_AddParam(loc,'internal', int.value);
    }
       //sort
    var so = AppliTrack_$('AppliTrackSort');
       if(so&&so.options&&''!=''+so.options[so.selectedIndex].value){
           loc = AppliTrack_AddParam(loc ,'AppliTrackSort',''+so.options[so.selectedIndex].value);
       }

       //display
    var m = AppliTrack_$('AppliTrackLayoutMode');
       if(m&&m.options&&''!=''+m.options[m.selectedIndex].value){
           loc = AppliTrack_AddParam(loc ,'AppliTrackLayoutMode',''+m.options[m.selectedIndex].value);
       }

    //expand/collapse
    if(arguments&&arguments.length==3&&arguments[2]&&(navigator.vendor+'').indexOf('Apple')==-1){
        loc = AppliTrack_AddParam(loc,'AppliTrackSearch','expanded');
    }



    //GET
    if(loc.match(/^&/g))  {loc = loc.substring(1,loc.length);}
    if(!loc.match(/^\?/g)){loc = '?' + loc;}
    if(loc.match(/[&\?]$/)!=null){loc = loc.substr(0,loc.length-1);}
        window.location = window.location.toString().replace(window.location.search,'') + loc;

    }

    // if no zip code show this
    else
    {
        if (zcv != null){
            zcv.style.visibility="visible";
        }
    }
}


function AppliTrack_isEmpty(s){
    var st = (s&&s.value?s.value:s);
    return !(st && ''!=''+st && 'undefined'!=''+st);
}

function AppliTrack_AddParam(loc,key,val){
    var rv = loc+'';
    if(!AppliTrack_isEmpty(key)&&!AppliTrack_isEmpty(val)){
        if (rv.match(new RegExp(key+'=',"ig"))){
            rv = AppliTrack_RemoveParam(rv,key);
           }
        if(rv.length>0 && !rv.match('&$')){rv += '&';}
           rv += key + "=" + escape(val);

    }
    return rv;
}

function AppliTrack_RemoveParam(loc,key){

    var rv = (loc+'').split('&');
    if(key!= ''){
        for(var i=0;i < rv.length;i++){
           if(rv[i].substring(0,key.length) == key){
                rv[i]='';
            }
        }
    }
    return (rv?rv.join('&').replace('&&','&'):'');
}
function AppliTrack_$(id) {
    var o = null;
    if( document.layers ) {
        o = document.layers[id];
    } else if( document.all ) {
        o = document.all[id];
    } else if( document.getElementById ) {
        o = document.getElementById(id);
    }
    return o;
}

document.write('<div id=\'AppliTrackOutput\'><form id=\'AppliTrackSearchForm\' name=\'AppliTrackSearchForm\' onsubmit=\'return false;\'><!-- LastMultiJobOutput: 5/21/2019 4:12:33 PM --><!-- dateadd: 5/21/2019 3:45:11 PM --><!-- UpdatingMultiJobBoard: False --><!-- Bool: True --><a name=AppliTrackPostings id=AppliTrackPostings></a><link rel=\'stylesheet\' type=\'text/css\' href=\'https://www.applitrack.com/olacommon/jobpostings/postingStyles.v3.css?v=8-17-2016\' /><div class=\'AppliTrackListHeader\'id=\'ApplicantMain\'><div>Openings as of 5/21/2019</div></div><br><div style=\'display: none;\'>force display?True</div><div id=\'AppliTrackListContent\'><p align=center class=noprint id=\'p5482_37440h\'><span class=\'ListHeader\'>Openings as of 5/21/2019<br/></span></p><ul class=\'postingsList\' id=\'p5482_37440\'><li class=\'title\'>Software Developer<span class=\'title2\' style=\'float:right;text-align:right;\'> JobID: 5482 <input type=\'button\' value=\' Apply \' onclick="applyFor(\'5482\',\'3000 Professional\',\'3205 Information Systems Professional\')" class=\'screenOnly ApplyButton\' /></span></li><li>&nbsp;</li><div style=\'position:relative;\'><li><span class=\'label\'>Position Type:</span><br/>&nbsp;&nbsp;<span class=\'normal\'>3000 Professional/</span><span class=\'normal\'>3205 Information Systems Professional</span><br/><br/></li><li><span class="label" >Date Posted:</span><br/>&nbsp;&nbsp;<span class="normal">4/8/2019</span><br/><br/></li><li><span class="label" >Location:</span><br/>&nbsp;&nbsp;<span class="normal">Grand Forks, North Dakota</span><br/><br/></li><li></li><li><span class="label" > Closing Date: </span><br/>&nbsp;&nbsp;<span class=\'normal\'>Opened until filled</span><br/><br/><span class=\'label\'>Institution:</span><br/>&nbsp&nbsp;<span class=\'normal\'>University of North Dakota</span>&nbsp;-&nbsp;<a href=\'http://und.edu/\'>website</a></li>');
function setUpPageBreaks(){h = 0; try{}catch(ex){}}
var h = 0
setTimeout("setUpPageBreaks()",100)
document.write('<span>&nbsp&nbsp</span><span class="normal"><br /> <span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 16px;"><strong><u>Hiring Department</u></strong>:&nbsp;<strong>Energy &amp; Environmental Research Center (EERC)</strong></span><br /> <br /> <span style="font-size: 14px;"><strong><u>Minimum Hiring Salary/Position Classification</u></strong>:&nbsp;$55,000+Depending upon experience and skillset, Full-Time, Benefited, Exempt<br /> <strong><u>Benefits</u></strong>: Includes single or family health care coverage (premiums paid for by the university), basic life insurance, EAP, retirement plan, tuition waiver, annual and sick leave.&nbsp; Optional benefits available: supplemental life, dental, vision, flexible spending account, supplemental retirement plans.&nbsp;<br /> <br /> <strong><u>Work Schedule</u></strong>:&nbsp; 8:00 a.m. to 5:00 p.m.; occasional work outside of regular hours.<br /> &nbsp;<br /> <strong>For full consideration, all application materials must be fully submitted by 5PM (Central Time) on the closing date</strong>.</span></span><br /> <span style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-family: tahoma,geneva,sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 700; text-decoration: none; word-spacing: 0px; float: none; display: inline !important; white-space: normal; orphans: 2; background-color: rgb(255, 255, 255); -webkit-text-stroke-width: 0px;">Internal applicants will receive first consideration.</span><br /> <br /> <span style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-family: tahoma,geneva,sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; float: none; display: inline !important; white-space: normal; orphans: 2; background-color: rgb(255, 255, 255); -webkit-text-stroke-width: 0px;">______________________________________________________________________________________________________</span><br style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-family: tahoma,geneva,sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; white-space: normal; orphans: 2; -webkit-text-stroke-width: 0px;" /> <br /> <span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;"><strong><u>Position Details:</u></strong>&nbsp;&nbsp;&nbsp;<strong><em>A Complete Position Description is available as an attachment in the bottom right corner of this position announcement.</em></strong><br /> <br /> At the Energy &amp; Environmental Research Center (EERC), we know our people are our greatest asset. Our team of over 200 is sought after worldwide to solve energy and environmental challenges in innovative ways. Since 1951, we&rsquo;ve worked with over 1,300 clients in 53 countries<strong>. </strong>We recognize that quality, market-driven science and engineering technologies come from engaged, motivated employees. We encourage lifelong learning through our Employee Development Program and offer many opportunities for both professional and personal growth. In addition to competitive salaries and an outstanding benefits package, the EERC provides opportunities for inventors of commercialized technologies to share in the profits. As the EERC is part of the University of North Dakota, employees are eligible for tuition waivers and reduced tuition for family members. <strong>Apply with us for a position that can turn into a lifelong passion and a work environment that&rsquo;s more like a family.</strong><br /> <br /> <strong><u>Position Responsibilities Overview</u></strong>:</span></span> <ul><li><span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;">Design, create, test, troubleshoot, and maintain new and existing software applications (desktop, Web-based, and mobile), many of which are database driven.</span></span></li> <li><span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;">Translate client requirements and formulate detailed specifications, budgets, and timelines.</span></span></li> <li><span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;">Create and maintain product documentation; independently research and resolve complex technical programming problems.</span></span></li> <li><span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;">Other duties as assigned.</span></span></li> <li><span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;">May require travel.</span></span></li> </ul> <br /> <span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;">This position does not support visa sponsorship for continued employment.</span></span><br /> <br /> <span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;">For more information regarding the EERC, visit&nbsp;<u><a href="http://www.undeerc.org/">www.undeerc.org</a></u>.</span></span><br /> <br /> <strong><u>Required Competencies</u>:</strong><br /> &nbsp;<ul><li>Organizational/prioritization ability.</li> <li>Excellent interpersonal/oral/written communication skills</li> <li>Ability to be self-motivated and self-directed.</li> <li>Ability and desire to learn and improve skills.</li> <li>Ability to take initiative, multi-task and work both independently and as part of a team.</li> </ul> <span style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-family: tahoma,geneva,sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; float: none; display: inline !important; white-space: normal; orphans: 2; background-color: rgb(255, 255, 255); -webkit-text-stroke-width: 0px;">________________________________________________________________________________________________________________</span><br /> <br /> <span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;"><strong><u>Required Qualifications:</u></strong></span></span> <ul><li>Bachelor&#39;s degree in computer science, information systems, business administration, or related field. A lesser degree with equivalent solid programming experience may be substituted.</li> <li>Programming experience in developing web, desktop or mobile.</li> <li>Database query writing experience (MS SQL Server preferred).</li> <li><span style="font-size: 14px;"><span style="font-family: tahoma,geneva,sans-serif;">Successful completion of criminal history background check</span></span></li> </ul>&nbsp; <p><span style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; white-space: normal; orphans: 2; -webkit-text-stroke-width: 0px;"><span style="font-family: tahoma,geneva,sans-serif;">In compliance with federal law, all persons hired will be required to verify identity and eligibility to work in the US and to complete the required employment eligibility verification form upon hire.&nbsp;</span></span><br /> <br /> <br /> <span style="font-family: tahoma,geneva,sans-serif;"><span style="font-size: 14px;"><strong><u>Preferred Qualifications:</u></strong></span></span></p>&nbsp; <ul><li>Experience with .Net technology (VB/C#).</li> <li>Knowledge of HTML, CSS, JavaScript, JQuery, Git, AJAX, ASP or PHP a plus.</li> <li>Experience in development using Microsoft Visual Studio</li> <li>Knowledge of Agile development methodologies.</li> <li>Experience designing web sites with content management systems.</li> <li>Experience in designing and creating database tables, functions, and stored procedures.</li> <li>Knowledge of PeopleSoft or UND financial system.</li> </ul> <br /> <span style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-size: 18px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; white-space: normal; orphans: 2; -webkit-text-stroke-width: 0px;"><span style="font-family: tahoma,geneva,sans-serif;"><strong>To find out why living and working in Greater Grand Forks is way cooler, check out <a href="http://www.grandforksiscooler.com/" style="color: rgb(7, 130, 193);"><font color="#0066cc">www.GrandForksisCooler.com</font></a></strong></span></span><br style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; white-space: normal; orphans: 2; -webkit-text-stroke-width: 0px;" /> <br style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; white-space: normal; orphans: 2; -webkit-text-stroke-width: 0px;" /> <br style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; white-space: normal; orphans: 2; -webkit-text-stroke-width: 0px;" /> <span style="text-align: left; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; letter-spacing: normal; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; text-decoration: none; word-spacing: 0px; white-space: normal; orphans: 2; -webkit-text-stroke-width: 0px;"><span style="font-family: tahoma,geneva,sans-serif;"><strong>All information listed in this position announcement will be used by Human Resources, the Hiring Department, and AAO for screening, interviewing and selection purposes.</strong><br /> <br /> <br /> <strong>Confidentiality of Application Materials</strong><br /> <em>Note: Pursuant to NDCC 44-04-18.27, applications and any records related to the applications that identify an applicant are confidential, except records related to the finalists of the position, which are open to the public after the search committee has identified the top three finalists who will be invited to campus.</em><br /> &nbsp;<br /> <strong>EEO Statement</strong><br /> <em>UND is an Equal Opportunity/Affirmative Action employer.&nbsp; All qualified applicants will receive consideration for employment without regard to race, color, religion, sex, sexual orientation, gender identity or national origin.&nbsp; Women, minorities, veterans and individuals with disabilities are encouraged to apply. Applicants are invited to provide information regarding their gender, race and/or ethnicity, veteran&rsquo;s status and disability status on the form found at </em><a href="http://und.edu/affirmative-action/apcontrolcard.cfm" style="color: rgb(7, 130, 193);"><em><font color="#0066cc">http://und.edu/affirmative-action/apcontrolcard.cfm</font></em></a><em>.&nbsp; This information will remain confidential and separate from your application.&nbsp; </em><br /> &nbsp;<br /> <strong>ND Veteran&rsquo;s Preference</strong><br /> <em>North Dakota Veterans claiming preference must submit all proof of eligibility by the closing date. Proof of eligibility includes a DD-214 and if claiming disabled status, a current letter of disability from the VA dated within the last 12 months.</em><br /> &nbsp;<br /> <strong>Clery Statement</strong><br /> <em>In compliance with the Jeanne Clery Disclosure of Campus Security Policy and Campus Crime Statistics Act, the University of North Dakota publishes an Annual Security and Fire Safety Report. &nbsp;The report includes the university&rsquo;s policies, procedures, and programs concerning safety and security, as well as three years&rsquo; of crime statistics for our campus. &nbsp;As a prospective employee, you are entitled to a copy of this report. &nbsp;The report and statistical data can be found online at </em><a href="http://und.edu/discover/_files/docs/annual-security-report.pdf" style="color: rgb(7, 130, 193);"><em><font color="#0066cc">http://und.edu/discover/_files/docs/annual-security-report.pdf</font></em></a><em>. &nbsp;You may also request a paper copy of the report from the UND Police Department located at 3851 Campus Road, Grand Forks, ND 58202.</em></span></span></span><br /><img src=\'https://www.applitrack.com/clear.gif\' height=8><br /><div class="AppliTrackJobPostingAttachments">Attachment(s):<ul><li><a rel="nofollow" target="_blank" href="https://www.applitrack.com/ndus/onlineapp/1BrowseFile.aspx?id=94130">5482 Software Developer Position Description.docx</a></li></ul></div><br/><div class=\'label\' align=\'right\' style=\'position:absolute; top:0%;right:1%;\'><span class=\'s\'><div class="addthis_toolbox addthis_default_style "><a class="addthis_button_preferred_1"></a><a class="addthis_button_preferred_2"></a><a class="addthis_button_preferred_3"></a><a class="addthis_button_compact"></a><a class="addthis_counter addthis_bubble_style"></a></div><script type="text/javascript" src="https://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4dfeb954767d3dc8"></script><br><a href=\'mailto:?subject=Job%20Posting&body=I%20thought%20you%20would%20be%20interested%20in%20an%20employment%20opportunity%20I%20found%20at%20North%20Dakota%20University%20System%2E%20The%20position%20is%20Software%20Developer%2E%20Please%20click%20the%20link%20below%20for%20more%20information%20about%20this%20vacancy%2E%0D%0A%0D%0Ahttps%3A%2F%2Fwww%2Eapplitrack%2Ecom%2Fndus%2Fonlineapp%2Fjobpostings%2Fview%2Easp%3Fall%3D1%26AppliTrackJobId%3D5482%5F37440%26AppliTrackLayoutMode%3Ddetail%26AppliTrackViewPosting%3D1\'><span style=\'color:#4c4c4c;font-size:.9em;font-weight:normal;\'>Email To A Friend</span></a><br/><a href=\'https://www.applitrack.com/ndus/onlineapp/jobpostings/view.asp?all=1&AppliTrackJobId=5482_37440&AppliTrackLayoutMode=detail&AppliTrackViewPosting=1\' target=_blank><span style=\'color:#4c4c4c;font-size:.9em;font-weight:normal;\'>Print Version</span> </a><br/></span></div><br/></div></ul><div style=\'width: 100%; height: .75px; background: gray; overflow: hidden; margin-bottom:4px;\'></div><br /></div><span class=\'screenOnly\'><br /><center><input type=\'button\' value=\'&lt;-- Back\' onclick=\'history.back()\' id=\'button1\' name=\'button1\' /><br/><br/>Postings current as of 5/21/2019 4:30:11 PM CST.</center><br /><br /><div class="subnotetext"></div></span><noscript>Powered by Aspex Solutions - AppliTrack, Applicant Tracking for Educators. Online Job Employment Applications, Web Based Employment Applications for School Districts and Educational Institutions - <a href=http://www.aspexsolutions.com/home/>www.aspexsolutions.com</a></noscript><noscript>You can also view <a href=\'http://www.k12jobspot.com/north dakota-teaching-jobs\'>North Dakota teaching jobs</a> at www.k12jobspot.com. K12JobSpot is a site that has thousands of teaching jobs - all from AppliTrack school districts.</noscript></form></div>');
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www."); document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));try {var pageTracker = _gat._getTracker("UA-12436368-1");pageTracker._trackPageview();} catch(err) {}

    if (document.getElementById("AppliTrackSearchContainer").getElementsByClassName("normal")[0].innerHTML.substring(0,21)=="Viewing All Districts") {
        document.getElementById("AppliTrackSearchContainer").getElementsByClassName("normal")[0].innerHTML = document.getElementById("AppliTrackSearchContainer").getElementsByClassName("normal")[0].innerHTML.replace("Viewing All Districts","Viewing All Institutions")
        }

