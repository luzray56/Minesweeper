import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 50;
private MSButton[][] buttons; 
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); 
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make( this );
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
    for (int i = 0; i < NUM_BOMBS; i++)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if (! bombs.contains(buttons[row][col]))
            bombs.add(buttons[row][col]);
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
    for(int i=0;i<NUM_ROWS;i++)
    {
        for(int j=0;j<NUM_COLS;j++)
        {
            if(!buttons[i][j].isClicked() == true && !bombs.contains(buttons[i][j]))
                return false;
        }
    }
    return true;
}
public void displayLosingMessage()
{
    for(int i=0;i<NUM_ROWS;i++)
    {
        for(int j=0;j<NUM_COLS;j++)
        {
            if (!buttons[i][j].isClicked()&&bombs.contains(buttons[i][j]))
            {
                buttons[i][j].marked=false;
                buttons[i][j].clicked=true;
            }
        }
    }
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
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("o");
    buttons[10][8].setLabel("u");
    buttons[10][10].setLabel("W");
    buttons[10][11].setLabel("i");
    buttons[10][12].setLabel("n");
    buttons[10][13].setLabel("!");
    buttons[10][15].setLabel(":)");
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
        Interactive.add( this ); 
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT)
        {
            if(marked)
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
        { 
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
                buttons[r-1][c+1].mousePressed(); 
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
        if (isWon() == true)
            displayWinningMessage();
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
            if (bombs.contains(buttons[row][col+1])) {numBombs++;}
        if(isValid(row,col-1))
            if(bombs.contains(buttons[row][col-1])) {numBombs++;}
        if(isValid(row+1,col))
            if(bombs.contains(buttons[row+1][col])) {numBombs++;}
        if(isValid(row-1,col))
            if(bombs.contains(buttons[row-1][col])) {numBombs++;}
        if(isValid(row-1,col+1))
            if(bombs.contains(buttons[row-1][col+1])) {numBombs++;}
        if(isValid(row+1,col+1))
            if(bombs.contains(buttons[row+1][col+1])) {numBombs++;}
        if(isValid(row-1,col-1))
            if(bombs.contains(buttons[row-1][col-1])) {numBombs++;}
        if(isValid(row+1,col-1))
            if(bombs.contains(buttons[row+1][col-1])) {numBombs++;}
        return numBombs;
    }
}