/*
*  UNIVERSIDAD TECNICA DEL NORTE
*  SISTEMAS EMBEBIDOS
*  STEVEN FLORES
*  5to CITEL
* Laboratorio 4
*/
import processing.serial.*;

int[][] matriz={
  {170,67},
  {180,80},
  {170,65},
  {178,75},
  {160,55},
  {163,60},
  {165,63},
  {170,70},
  {164,62},
  {176,77},
  {164,60},
  {170,76},
  {170,56},
  {168,60},
};
int col = 0; //Moverse en columnas
int fil = 0; //Moverse en filas
float Ex=0;   //Sumatoria x
float Yp=0;   //Y prima
float Eyp=0;   //Sumatoria y prima  
float Exyp=0;     //Sumatoria xyprima
float Ex2=0;   //Sumatoria x^2
float Ex_2=0;    //(Sumatoria x)^2
int n = 14; //tam muestras
float Bo; //ordenada en el origen
float m; //pendiente
String dato; //Recibir estatura
int estatura; //Convertir dato
float m1; //aux
int x = 110;
int y = 110;
float i = 0;
int j = 0;
float a =0;
float b=0;
int alt;
float peso; 
Serial port;
void setup(){
 port=new Serial(this,"COM10",9600);
 size (700,700);
 background(255,245,240);
 fill(1);
 textSize(25);
 text("Laboratorio 4-STEVEN FLORES",50,50);
 regresion();
}

void draw(){
  fill(255);
  rect(50,200,600,400);
  for(i=0;i<30;){
        i=i+0.1;
        a=i+150;
        b=m*exp(a*Bo);
        stroke(3,255,4);
        fill(3,255,4);
        ellipse(50+((a-150)*20),600-(b*5),1,1);
    }
  for(j=0;j<9;j++){
      stroke(1);
      line(50,200+(j*50),650,200+(j*50));  
      line(50+(j*100),200,50+(j*100),600);
      fill(1);
      textSize(15);
      text(80-(j*10),20,200+(j*50));
      textSize(15);
      text(150+(j*5),40+(j*100),620);
  }
    for(j=0;j<14;j++){
        fill(0,0,255);
        ellipse(50+((matriz[j][0]-150)*20),600-(matriz[j][1]*5),7,7);
      }
      peso=m*exp(alt*Bo);
      stroke(255,0,0);
      fill(255,0,0);
      ellipse(50+((alt-150)*20),600-(peso*5),7,7);
             
}
void regresion(){
   for(;fil<n;fil++){
      Ex=Ex+matriz[fil][0];
      Yp=(log(matriz[fil][1]));
      Eyp=Eyp+Yp;
      Exyp=Exyp+(matriz[fil][0]*Yp);
      Ex2=Ex2+pow(matriz[fil][0],2);    
    }
    Ex_2=pow(Ex,2);
    Bo=((n*Exyp)-(Ex*Eyp))/((n*Ex2-Ex_2));
    m1=(Eyp/14)-(Bo*(Ex/14));
    m=exp(m1);    
}

void serialEvent(Serial port){
  alt = port.read();

}
