model classroom_simulation

//creating the environment
global {
	float world_size <- 40.0;
	
	//monitoring values
	float avg_score -> { student mean_of each.score };
	float avg_energy -> { student mean_of each.energy };
	int inactive_student -> { student count (each.status = "inactive") };
   
	init {
      	create student number: 20; 
   	}
}


//Creating a student speicies
species student {
   int energy <- 5;
   int score <- 0;
   string status <- "active";
   
   //color coding (green as active)
   rgb color <- #green;
   
   reflex participate when: status = "active" {
      if flip(0.8) {					
         score <- score + 1;
         energy <- energy - 1;
      }
   }
	// update the status of students
   reflex update_status {
   if energy <= 0 {
      status <- "inactive";
      color <- #red;
   }
}
   
      aspect base {
      draw circle(2) color: color; 		
   }
}


//creating experiment visual
experiment classroom_simulation type: gui {
	
   output {
      display main_display type: 2d {
         species student aspect: base;
      }
      
      monitor "Average Score" value: avg_score;
      monitor "Average Energy" value: avg_energy;
      monitor "Inactive Students" value: inactive_student;
   }
}