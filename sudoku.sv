`define N 3
`define M 9

class sudoku;
  
  rand int box [`M][`M];
  
  int puzzle [`M][`M] = 
  	'{
      '{ 0,2,3, 4,0,6, 7,8,0 },
      '{ 4,0,6, 7,0,9, 1,0,3 },
      '{ 7,8,0, 0,2,0, 0,5,6 },
      
      '{ 2,3,0, 0,6,0, 0,9,1 },
      '{ 0,0,7, 8,0,1, 2,0,0 },
      '{ 8,9,0, 0,3,0, 0,6,7 },
      
      '{ 3,4,0, 0,7,0, 0,1,2 },
      '{ 6,0,8, 9,0,2, 3,0,5 },
      '{ 0,1,2, 3,0,5, 6,7,0 } };
  
  constraint tc {
    
    foreach (box[i,j]) {
      box[i][j] inside {[1:9]};
      puzzle[i][j] != 0 -> box[i][j] == puzzle[i][j];
    }
    
    foreach (box[i,j]) {
      foreach (box[ii,jj]) {
        ((ii == i) && (jj != j)) -> box[ii][jj] != box[i][j];
        ((ii != i) && (jj == j)) -> box[ii][jj] != box[i][j]; 
        ((i/3 == ii/3) && (j/3 == jj/3) && (i!=ii || j!=jj)) -> box[ii][jj] != box[i][j];
      }
    }
  }   
               
  function void print();
    string s;
    foreach (box[i]) begin
      s = "";
      foreach (box[i][j]) begin
        s = {s, " ", $sformatf("%d", box[i][j])};
      end
      $display(" %s",s);
    end
  endfunction
             
endclass          
               
module automatic test;
  function void run();
    sudoku m_sudoku = new();
    for(int i = 0; i < 1; i=i+1) begin
      $display("RANDOMIZE %0d", i);
      m_sudoku.randomize();
      m_sudoku.print();
    end
  endfunction
  initial begin
    run();
  end
endmodule