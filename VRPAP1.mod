/*********************************************
 * OPL 22.1.0.0 Model
 * Author: mehmet
 * Creation Date: 11.04.2023 at 00:10:05
 *********************************************/
 // Definiere Sets
int num_customers = 9;
int num_TW = 10;
range C = 1..num_customers;
range N = 0..num_customers;
range W = 1..num_TW;


// Definiere Parameter
float c[N][N] = [[1000.0, 7.98, 6.12, 5.29, 8.95, 6.85, 7.24, 5.95, 9.15, 5.38],// Transportkosten von i zu j
				 [7.98, 1000.0, 5.40, 8.30, 7.48, 9.72, 7.45, 5.71, 6.75, 7.30],
				 [6.12, 5.40, 1000.0, 8.54, 5.88, 7.68, 8.76, 9.97, 9.77, 8.91],
				 [5.29, 8.30, 8.54, 1000.0, 9.90, 7.60, 8.87, 8.88, 6.57, 6.00],
				 [8.95, 7.48, 5.88, 9.90, 1000.0, 5.69, 6.33, 6.07, 9.30, 5.81],
				 [6.85, 9.72, 7.68, 7.60, 5.69, 1000.0, 8.79, 7.72, 6.28, 6.80],
				 [7.24, 7.45, 8.76, 8.87, 6.33, 8.79, 1000.0, 6.15, 7.02, 5.60],
				 [5.95, 5.71, 9.97, 8.88, 6.07, 7.72, 6.15, 1000.0, 6.34, 6.62],
				 [9.15, 6.75, 9.77, 6.57, 9.30, 6.28, 7.02, 6.34, 1000.0, 8.29],
				 [5.38, 7.30, 8.91, 6.00, 5.81, 6.80, 5.60, 6.62, 8.29, 1000.0]];
				
                 
                 
float t[N][N] = [[0.0, 1.63, 1.26, 2.23, 1.80, 3.36, 2.26, 1.08, 0.75, 2.57],
				  [1.63, 0.0, 1.21, 1.56, 3.05, 4.03, 3.89, 2.52, 1.39, 2.78],
				  [1.26, 1.21, 0.0, 0.97, 1.99, 2.83, 3.22, 2.31, 1.59, 3.43],
				  [2.23, 1.56, 0.97, 0.0, 2.66, 2.86, 4.15, 3.31, 2.50, 4.22],
				  [1.80, 3.05, 1.99, 2.66, 0.0, 1.89, 1.87, 2.24, 2.54, 4.25],
				  [3.36, 4.03, 2.83, 2.86, 1.89, 0.0, 3.65, 4.06, 4.08, 5.93],
				  [2.26, 3.89, 3.22, 4.15, 1.87, 3.65, 0.0, 1.69, 2.74, 3.72],
				  [1.08, 2.52, 2.31, 3.31, 2.24, 4.06, 1.69, 0.0, 1.16, 2.13],
				  [0.75, 1.39, 1.59, 2.50, 2.54, 4.08, 2.74, 1.16, 0.0, 1.88],
				  [2.57, 2.78, 3.43, 4.22, 4.25, 5.93, 3.72, 2.13, 1.88, 0.0]];

                  
int d[C] = [25, 5, 20, 18, 17, 11, 4, 7, 13]; // Bedarf von Kunde j

float S[C] = [5.0, 3.5, 5.0, 5.0, 4.5, 4.0, 3.5, 4.0, 4.5]; // Servicedauer beim Kunden j

float p[C][W] = [[0.20, 0.20, 0.30, 0.40, 0.50, 0.90, 0.80, 0.70, 0.60, 0.50], // Kunde 1 // Verfügbarkeitswahrscheinlichkeit von Kunde j während TW w
			   [0.10, 0.20, 0.30, 0.90, 0.80, 0.70, 0.60, 0.50, 0.40, 0.30], // Kunde 2
			   [0.10, 0.20, 0.30, 0.40, 0.50, 0.90, 0.80, 0.70, 0.60, 0.50], // Kunde 3
			   [0.10, 0.20, 0.30, 0.90, 0.80, 0.70, 0.60, 0.50, 0.40, 0.30], // Kunde 4
			   [0.10, 0.20, 0.30, 0.40, 0.50, 0.90, 0.80, 0.70, 0.60, 0.50], // Kunde 5
			   [0.10, 0.20, 0.30, 0.90, 0.80, 0.70, 0.60, 0.50, 0.40, 0.30], // Kunde 6
			   [0.10, 0.20, 0.30, 0.90, 0.80, 0.70, 0.60, 0.50, 0.40, 0.30], // Kunde 7
			   [0.10, 0.20, 0.30, 0.90, 0.80, 0.70, 0.60, 0.50, 0.40, 0.30], // Kunde 8
			   [0.80, 0.90, 0.80, 0.70, 0.60, 0.50, 0.40, 0.30, 0.20, 0.10]]; // Kunde 9
			  
 
float cjfailed[C] = [1.23, 0.86, 1.25, 1.24, 1.16, 1.01, 0.86, 0.97, 1.02]; // Fehlzustellkosten für Kunde j

float e[C][W] = [[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 1 // Früherster Start vom Service im TW w für Kunde j
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 2
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 3
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 4
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 5
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 6
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 7
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0], // Kunde 8
				[0.0, 60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0]]; // Kunde 9
				
float l[C][W] = [[60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 1 // Spätestes Ende vom Service im TW w für Kunde j
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 2
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 3
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 4
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 5
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 6
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 7
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0], // Kunde 8
			   [60.0, 120.0, 180.0, 240.0, 300.0, 360.0, 420.0, 480.0, 540.0, 600.0]]; // Kunde 9 
			   
int K = 3; // Maximale Anzahl Fahrzeuge
float Q = 40; // Maximale Kapazität von den Fahrzeugen
float D = 600; // Lieferperioden Länge

// Define Decision Variables
dvar boolean x[N][N]; // Binäre Variable aussagend welcher arc (i,j) genutzt wird
dvar boolean z[C][W]; // Binäre Variable aussagend welcher TW w gewählt wurde für den Kunden j
dvar float+ s[N]; // Startzeiztpunkt vom Service am Knoten i
dvar float+ q[N]; // Akkumulierte Ladung am Knoten i

// Zielfunktion
minimize sum(i in N, j in N) c[i][j]*x[i][j] + sum(j in C, w in W) cjfailed[j]*(1-p[j][w])*z[j][w];

// Nebenbedingungen
subject to {
  // Limit Anzahl an Fahrzeugen/Routen //NB1
  sum(j in C) x[0][j] <= K; 
  
  // Jeder Kunde wird nur einmal besucht //NB2
  forall(j in C) sum(i in N) x[i][j] == 1; 
  
  // Fluss Nebenbedingung //NB3
  forall(i in N) sum(j in N) x[i][j] == sum(j in N) x[j][i];
  
  // Kapazitäts Nebenbedingungen
  forall(i,j in C: i != j) q[j] - q[i] >= d[j] - Q*(1 - x[i][j]); //NB4
  forall(j in C) d[j] <= q[j] <= Q; //NB5
  
  // Lieferperiode Nebenbedingung //NB6
  forall(i,j in C: i != j) s[j] + S[j] + t[j][0] <= D;
  
  // Kurzzyklus Nebenbedingung //NB7
  forall(i,j in C: i != j) s[j] - s[i] >= (t[i][j] + S[i])*x[i][j] - D*(1 - x[i][j]);
  
  // Time window Nebenbedingung //NB8
  forall(j in C) sum(w in W) e[j][w]*z[j][w] <= s[j];
  forall(j in C) s[j] <= sum(w in W) l[j][w]*z[j][w];
  
  // Jeder Kunde hat genau eine Nebenbedingung //NB9
  forall(j in C) sum(w in W) z[j][w] == 1;
  
  // Decision variables are binary or non-negative
  forall(i in N) s[i] >= 0;
  forall(i in N) q[i] >= 0;
}  