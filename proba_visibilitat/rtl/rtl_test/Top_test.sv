//`include "interface.sv"

module Top_test;  

  int x,a,b,y1,y2;
  int sig;

  initial begin
    sig = 1;
  /*$display("Start simulation");
  a = 1'b1;
  #10
  a = 1'b0;
  #10
  a = 1'b1;
  $display("End simulation");

  //$finish;
  
  a =  25000000;
  b = 26000000;
  y1 = a * 2;
  y2 = b * 2;*/

  fork

    begin
      #200
      sig = 0;
      $display("done 3");
    end

    begin
      while (sig) begin
        x ++;
        $display("first done");
      end
      $display("first x: %d", x);
    end

    begin
      while(sig) begin
        x ++; // load add store
        $display("second done");
      end
      $display("second x: %d", x);
    end

    

  join

  $finish;
  end

  /*Top_soc u_Top_soc (
  .a_i    (a)
  );*/

endmodule


task automatic taskName();
  
endtask //automatic



/*module Top_test;
  semaphore sema; //declaring semaphore sema
 
  initial begin
    //sema=new(4); //creating sema with '4' keys
    fork
      display(2); //process-1
      display(3); //process-2
      display(2); //process-3
      display(1); //process-4
    join
  end
 
  //display method
  task automatic display(int key);
    //sema.get(key); //getting 'key' number of keys from sema
    $display($time,"\tCurrent Simulation Time, Got %0d keys",key);
    #30;
    //sema.put(key); //putting 'key' number of keys to sema
  endtask
endmodule*/

