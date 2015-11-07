/* [Global] */

/*[Picture Size]*/

//Picture width in mm
drawingWidth = 54;
//Picture length in mm
drawingHeight = 68.4;
//Picture Thickness, default=0.6
pthick = 0.6;       

/*[Frame Setting]*/

//Control frame edge on width
Widthindex = 12;    //[6:30]
//Control frame edge on length
Lengthindex = 5;    //[6:30]
//Thickness of the outter frame
blackframethick = 3;    //[2:6]
//Height of levelup the frame
wallmount = 6;
//Need to the levelup back stand?
levelup = 0;  //[0:Yes,1:No]
//3D object rendering
object = 3;  //[0:ALL,1:Innerframe, 2:Outerframe+Levelup, 3:Outerframe, 4:Levelup ]  



/* [Hidden] */

holeoffset = 3;
whiteoutthick = 2.2;  ///2.5-3

blackframespace = 0.7;  

pwidth = drawingWidth +1;
pheight = drawingHeight+1;

whitewidth = pwidth/Widthindex;      //6
whiteheight = pwidth/Lengthindex;

blackframeW = whiteheight/blackframethick;

backthick = pthick+1;    

//////////////////////////////


totalW = pwidth + whitewidth*2;  
totalH = pheight + whiteheight*2;  

holeW = pwidth-holeoffset;
holeH = pheight-holeoffset;

/////Inner Frame////
if (object == 0 || object == 1 ){
difference(){


cube([totalW  , totalH ,whiteoutthick]);
    
translate([(totalW-holeW)/2,(totalH-holeH)/2,-whiteoutthick])
cube([holeW,holeH,whiteoutthick*4]);
    
translate([(totalW-(holeW+whitewidth/3))/2,(totalH-(holeH+whitewidth/3))/2,whiteoutthick*0.6])
cube([holeW+whitewidth/3,holeH+whitewidth/3,whiteoutthick*4]);


}
}
/////Outer Frame////
if (object == 0 || object == 2 || object == 3){
translate([0,0,-backthick]){
difference(){

  translate([-(blackframeW+blackframespace)/2,-(blackframeW+blackframespace)/2,0]) 
 cube([totalW+blackframeW+blackframespace  , totalH+blackframeW+blackframespace ,whiteoutthick+backthick+2.5]);  
    
    translate([-blackframespace/2,-blackframespace/2,backthick])
   cube([totalW+blackframespace,totalH+blackframespace,whiteoutthick*4]); 
    
    if (levelup==0)     //REQUIRE levelup
        translate([(totalW-pwidth)/2,(totalH-pheight)/2,backthick-pthick-backthick])  
   cube([pwidth,pheight,whiteoutthick*4]);
    
    
    if (levelup==1)  //NO levelup
   translate([(totalW-pwidth)/2,(totalH-pheight)/2,backthick-pthick])  
   cube([pwidth,pheight,whiteoutthick*4]);
  
 
    
    
translate([0,0,-2])
intersection() {
    
   translate([-blackframespace/2,-blackframespace/2,0])
   cube([totalW+blackframespace,totalH+blackframespace,whiteoutthick*6]); 
    
    union(){
    cylinder(h = 5, r=whitewidth*1.1, $fn=30);
    translate([0,totalH+blackframespace,0])
    cylinder(h = 5, r=whitewidth*1.1, $fn=30);
    }
}   
}
}
////lock the paper
translate([whitewidth,whiteheight,0])
rotate([0,0,45])
translate([-0.1,-2.5,-0.2])
cube([2,5,0.2]);

translate([whitewidth+pwidth,whiteheight+pheight,0])
rotate([0,0,225])
translate([-0.1,-2.5,-0.2])
cube([2,5,0.2]);


}

///Level Up///
if (object == 0 || object == 2 || object == 4 )
    if(levelup==0)
{
translate([0,0,-10]){
translate([(totalW-(pwidth-1))/2,(totalH-(pheight-1))/2,-backthick])  
cube([ pwidth-1, pheight-1,1]);
    
difference(){
hull()
    {
translate([(totalW-pwidth-1)/2,(totalH-pheight-1)/2,-wallmount-backthick])
    translate([0,0,wallmount-1])
cube([ pwidth+1,pheight+1,0.01]);
        
        
translate([(totalW-pwidth+1)/2,(totalH-pheight+1)/2,-wallmount-backthick])
    translate([0,0,wallmount])
cube([ pwidth-1,pheight-1,0.01]);
        
    
translate([(totalW-totalW/2)/2,(totalH-totalH/2)/2,-wallmount-backthick])
cube([ totalW/2,totalH/2,0.01]); 
    }



translate([0,0,-wallmount/2])
intersection() {
    
   translate([-blackframespace/2,-blackframespace/2,0])
   cube([totalW+blackframespace,totalH+blackframespace,whiteoutthick*6]); 
    
    union(){
    cylinder(h = 5, r=whitewidth*1.1, $fn=30);
    translate([0,totalH+blackframespace,0])
    cylinder(h = 5, r=whitewidth*1.1, $fn=30);
    }
}
}
}
}

