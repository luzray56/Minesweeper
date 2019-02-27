import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for (int i = 0; i < NUM_ROWS; i++) 
    {
        for (int j = 0; j < NUM_COLS; j++)
            buttons[i][j] = new MSButton(i, j);
    }
    setBombs();
}
public void setBombs()
{
    //your code
    for (int i = 0; i < 10; i++)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if (! bombs.contains(buttons[row][col]))
            bombs.add(buttons[row][col]);
        println(row, col);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("o");
    buttons[10][8].setLabel("u");
    buttons[10][10].setLabel("L");
    buttons[10][11].setLabel("o");
    buttons[10][12].setLabel("s");
    buttons[10][13].setLabel("e");
    buttons[10][14].setLabel("!");
}
public void displayWinningMessage()
{
    //your code here
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT)
        {
            if(marked) // this might be wrong
                marked = false;
            else
                marked = true;
        }
        else if (bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if (countBombs(r, c) > 0)
        {
            setLabel("" + (countBombs(r, c)));
        }
        else
        { /*
            if(c>0 && buttons[r][c-1].clicked ==false)
                buttons[r][c-1].mousePressed();
            if(c<19 && buttons[r][c+1].clicked ==false)
                buttons[r][c+1].mousePressed();
            if(r>0 && buttons[r-1][c].clicked ==false)
                buttons[r-1][c].mousePressed();
            if(r<19 && buttons[r+1][c].clicked ==false)
                buttons[r+1][c].mousePressed();
            if(r>0 && c>0 && buttons[r-1][c-1].clicked ==false)
                buttons[r-1][c-1].mousePressed();
            if(r<19 && c<19 && buttons[r+1][c+1].clicked ==false)
                buttons[r+1][c+1].mousePressed();
            if(r<19 && c>0 && buttons[r+1][c-1].clicked ==false)
                buttons[r+1][c-1].mousePressed();
            if(r>0 && c<19 && buttons[r-1][c+1].clicked ==false)
                buttons[r-1][c+1].mousePressed(); */
            for (int i = r-1; i < r+2; i++)
            {
                for (int j = c-1; j < c+2; j++)
                {
                    
                }
            } 
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r < 20 && r >= 0 && c < 20 && c >= 0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row,col+1))
            if (bombs.contains(buttons[row][col+1])){numBombs++;}
        if(isValid(row,col-1))
            if(bombs.contains(buttons[row][col-1])){numBombs++;}
        if(isValid(row+1,col))
            if(bombs.contains(buttons[row+1][col])){numBombs++;}
        if(isValid(row-1,col))
            if(bombs.contains(buttons[row-1][col])){numBombs++;}
        if(isValid(row-1,col+1))
            if(bombs.contains(buttons[row-1][col+1])){numBombs++;}
        if(isValid(row+1,col+1))
            if(bombs.contains(buttons[row+1][col+1])){numBombs++;}
        if(isValid(row-1,col-1))
            if(bombs.contains(buttons[row-1][col-1])){numBombs++;}
        if(isValid(row+1,col-1))
            if(bombs.contains(buttons[row+1][col-1])){numBombs++;}
        return numBombs;
    }
}



