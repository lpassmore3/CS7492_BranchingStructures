// CS 7492 - Simulation of Biology
// Project 4: Branching Structures (DLA & DBM)
// Author: Austin Passmore

public class Cell {

  private int i;
  private int j;
  private float potential;
  private State state;
  
  private float Phi_i_eta;
  private float p_i;
  private float partial_sum_i;
  
  public Cell(int i, int j) {
    this.i = i;
    this.j = j;
    this.potential = 0;
    this.state = State.EMPTY;
    
    this.Phi_i_eta = 0;
    this.p_i = 0;
    this.partial_sum_i = 0;
  }
  
  public int getI() {
    return this.i;
  }
  
  public int getJ() {
    return this.j;
  }
  
  public float getPotential() {
    return this.potential;
  }
  
  public void setPotential(float potential) {
    this.potential = potential;
  }
  
  public State getState() {
    return this.state;
  }
  
  public void setState(State state) {
    this.state = state;
  }
  
  public float getPhiIEta() {
    return this.Phi_i_eta;
  }
  
  public void setPhiIEta(float n) {
    this.Phi_i_eta = n;
  }
  
  public float getPI() {
    return this.p_i;
  }
  
  public void setPI(float n) {
    this.p_i = n;
  }
  
  public float getPartialSumI() {
    return this.partial_sum_i;
  }
  
  public void setPartialSumI(float n) {
    this.partial_sum_i = n;
  }
  
}
