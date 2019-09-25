// CS 7492 - Simulation of Biology
// Project 4: Branching Structures (DLA & DBM)
// Author: Austin Passmore

int cellSize = 2;    // each grid space is 2x2 pixels
int gridSizeX = 200;  // the grid will be 200x200 cells
int gridSizeY = 200;

boolean isSimulating = false;  // controls whether the simulation is paused or not

// Control parameters
boolean modeDLA = false;
boolean modeDBM = false;
float stickiness = 0;
float eta = 0;

// Data structures
Cell[][] grid;
ArrayList<Cell> pattern;
ArrayList<Cell> candidates; // only for DBM

void setup() {
  size(400, 400);
  background(0, 0, 0);    // set the background to black
  noStroke();
  
  reset();
}

void draw() {
  drawCells();
  if (isSimulating) {
    if (modeDLA) {
      stepDLA();
    } else if (modeDBM) {
      stepDBM();
    }
  }
}

// Controls keyboard inputs
void keyPressed() {
  if (key == ' ') {  // Pause and unpause the simulation
    if (isSimulating) {
      isSimulating = false;
      println("Simulation paused.");
    } else {
      isSimulating = true;
      println("Simulation playing.");
    }
  } else if (key == '1') {  // DLA, stickiness = 1.0
    modeDBM = false;
    modeDLA = true;
    stickiness = 1.0;
    isSimulating = false;
    reset();
    clear();
    println("DLA, stickiness = 1.0");
  } else if (key == '2') {  // DLA, stickiness = 0.1
    modeDBM = false;
    modeDLA = true;
    stickiness = 0.1;
    isSimulating = false;
    reset();
    clear();
    println("DLA, stickiness = 0.1");
  } else if (key == '3') {  // DLA, stickiness = 0.01
    modeDBM = false;
    modeDLA = true;
    stickiness = 0.01;
    isSimulating = false;
    reset();
    clear();
    println("DLA, stickiness = 0.01");
  } else if (key == '4') {  // DBM, stickiness = 0
    modeDLA = false;
    modeDBM = true;
    eta = 0;
    isSimulating = false;
    reset();
    initalizeDBM();
    clear();
    println("DBM, eta = 0");
  } else if (key == '5') {  // DBM, stickiness = 3
    modeDLA = false;
    modeDBM = true;
    eta = 3;
    isSimulating = false;
    reset();
    initalizeDBM();
    clear();
    println("DBM, eta = 3");
  } else if (key == '6') {  // DBM, stickiness = 6
    modeDLA = false;
    modeDBM = true;
    eta = 6;
    isSimulating = false;
    reset();
    initalizeDBM();
    clear();
    println("DBM, eta = 6");
  } else if (key == '0') {  // DLA, stickiness = 0.8, 9 seeds
    modeDBM = false;
    modeDLA = true;
    stickiness = 0.8;
    isSimulating = false;
    reset();
    addCustomSeeds();
    clear();
    println("DLA, stickiness = 0.8, 9 seeds");
  }
}

// Colors each cell white if it is in the pattern
void drawCells() {
  fill(255, 255, 255);
  for (int n = 0; n < pattern.size(); n++) {
    Cell cell = pattern.get(n);
    int i = cell.getI();
    int j = cell.getJ();    
    rect(j * cellSize, i * cellSize, cellSize, cellSize); 
  }
  
  //// Colors candidates blue for DBM
  //if (modeDBM) {
  //  fill(0, 0, 255);
  //  for (int n = 0; n < candidates.size(); n++) {
  //    Cell cell = candidates.get(n);
  //    int i = cell.getI();
  //    int j = cell.getJ();    
  //    rect(j * cellSize, i * cellSize, cellSize, cellSize); 
  //  }
  //}
}

// Resets the seed when changing simulation option
void reset() {
  grid = new Cell[gridSizeY][gridSizeX];
  pattern = new ArrayList<Cell>();
  for (int i = 0; i < gridSizeY; i++) {
    for (int j = 0; j < gridSizeX; j++) {
      Cell cell = new Cell(i, j);
      grid[i][j] = cell;
      if (i == gridSizeY / 2 && j == gridSizeX / 2) {    // the seed cell
        cell.setState(State.FILLED);
        pattern.add(cell);
      }
    }
  }
}

// Adds more seeds for the custom DLA simulation.
// The seeds added 9 extra seeds.
void addCustomSeeds() {
  
  int x = gridSizeX / 2;
  int y = gridSizeY / 2;
  int xChange = gridSizeX / 15;
  int yChange = gridSizeY / 15;
  
  grid[y][x - 2 * xChange].setState(State.FILLED);
  pattern.add(grid[y][x - 2 * xChange]);
  
  grid[y][x + 2 * xChange].setState(State.FILLED);
  pattern.add(grid[y][x + 2 * xChange]);
  
  grid[y - 2 * yChange][x].setState(State.FILLED);
  pattern.add(grid[y - 2 * yChange][x]);
  
  grid[y + 2 * yChange][x].setState(State.FILLED);
  pattern.add(grid[y + 2 * yChange][x]);
  
  grid[y - 4 * yChange][x - 4 * xChange].setState(State.FILLED);
  pattern.add(grid[y - 4 * yChange][x - 4 * xChange]);
  
  grid[y - 4 * yChange][x + 4 * xChange].setState(State.FILLED);
  pattern.add(grid[y - 4 * yChange][x + 4 * xChange]);
  
  grid[y + 4 * yChange][x - 4 * xChange].setState(State.FILLED);
  pattern.add(grid[y + 4 * yChange][x - 4 * xChange]);
  
  grid[y + 4 * yChange][x + 4 * xChange].setState(State.FILLED);
  pattern.add(grid[y + 4 * yChange][x + 4 * xChange]);
  
  //grid[y][x - 4 * xChange].setState(State.FILLED);
  //pattern.add(grid[y][x - 4 * xChange]);
  
  //grid[y][x + 4 * xChange].setState(State.FILLED);
  //pattern.add(grid[y][x + 4 * xChange]);
  
  //grid[y - 4 * yChange][x].setState(State.FILLED);
  //pattern.add(grid[y - 4 * yChange][x]);
  
  //grid[y + 4 * yChange][x].setState(State.FILLED);
  //pattern.add(grid[y + 4 * yChange][x]);
  
}

// Do one step of the Diffusion Limited Aggregation algorithm
void stepDLA() {
  // Randomly select a grid point
  int i = int(random(gridSizeY));
  int j = int(random(gridSizeX));
  
  //// Check neightbors (4 or 8)
  boolean addToPattern = false;
  while (!addToPattern) {
    boolean hasFilledNeighbor = checkNeighbors(i, j);
    if (hasFilledNeighbor) {  // The walk has a filled neighbor
      float stickChance = random(1);
      if (stickChance <= stickiness) {  // Compare the stickiness factor
        grid[i][j].setState(State.FILLED);
        pattern.add(grid[i][j]);
        addToPattern = true;
      } else {  // Continue the random walk if it does not stick
        float walkDirection = random(1);
        if (walkDirection < 1.0 / 8.0) {
          if (i - 1 >= 0) {
            i = i - 1;
          }
        } else if (walkDirection >= 1.0 / 8.0 && walkDirection < 2.0 / 8.0) {
          if (i + 1 < gridSizeY) {
            i = i + 1;
          } 
        } else if (walkDirection >= 2.0 / 8.0 && walkDirection < 3.0 / 8.0) {
          if (j - 1 >= 0) {
            j = j - 1;
          }
        } else if (walkDirection >= 3.0 / 8.0 && walkDirection < 4.0 / 8.0) {
          if (j + 1 < gridSizeX) {
            j = j + 1;
          }
        } else if (walkDirection >= 4.0 / 8.0 && walkDirection < 5.0 / 8.0) {
          if (i - 1 >= 0 && j - 1 >= 0) {
            i = i - 1;
            j = j - 1;
          }
        } else if (walkDirection >= 5.0 / 8.0 && walkDirection < 6.0 / 8.0) {
          if (i + 1 < gridSizeY && j - 1 >= 0) {
            i = i + 1;
            j = j - 1;
          }
        } else if (walkDirection >= 6.0 / 8.0 && walkDirection < 7.0 / 8.0) {
          if (i - 1 >= 0 && j + 1 < gridSizeX) {
            i = i - 1;
            j = j + 1;
          }
        } else {
          if (i + 1 < gridSizeY && j + 1 < gridSizeX) {
            i = i + 1;
            j = j + 1;
          }
        }
      }
    } else {  // Continue the random walk if no neighbors in the pattern
      float walkDirection = random(1);
      if (walkDirection < 1.0 / 8.0) {
        if (i - 1 >= 0) {
          i = i - 1;
        }
      } else if (walkDirection >= 1.0 / 8.0 && walkDirection < 2.0 / 8.0) {
        if (i + 1 < gridSizeY) {
          i = i + 1;
        } 
      } else if (walkDirection >= 2.0 / 8.0 && walkDirection < 3.0 / 8.0) {
        if (j - 1 >= 0) {
          j = j - 1;
        }
      } else if (walkDirection >= 3.0 / 8.0 && walkDirection < 4.0 / 8.0) {
        if (j + 1 < gridSizeX) {
          j = j + 1;
        }
      } else if (walkDirection >= 4.0 / 8.0 && walkDirection < 5.0 / 8.0) {
        if (i - 1 >= 0 && j - 1 >= 0) {
          i = i - 1;
          j = j - 1;
        }
      } else if (walkDirection >= 5.0 / 8.0 && walkDirection < 6.0 / 8.0) {
        if (i + 1 < gridSizeY && j - 1 >= 0) {
          i = i + 1;
          j = j - 1;
        }
      } else if (walkDirection >= 6.0 / 8.0 && walkDirection < 7.0 / 8.0) {
        if (i - 1 >= 0 && j + 1 < gridSizeX) {
          i = i - 1;
          j = j + 1;
        }
      } else {
        if (i + 1 < gridSizeY && j + 1 < gridSizeX) {
          i = i + 1;
          j = j + 1;
        }
      }
    }
  }
}

// Checks neighbors of a grid cell for DLA
boolean checkNeighbors(int i, int j) {
  if (i - 1 >= 0) {
    if (grid[i - 1][j].getState() == State.FILLED) {
      return true;
    }
  }
  if (i + 1 < gridSizeY) {
    if (grid[i + 1][j].getState() == State.FILLED) {
      return true;
    }
  }
  if (j - 1 >= 0) {
    if (grid[i][j - 1].getState() == State.FILLED) {
      return true;
    } 
  }
  if (j + 1 < gridSizeX) {
    if (grid[i][j + 1].getState() == State.FILLED) {
      return true;
    }
  }
  if (i - 1 >= 0 && j - 1 >= 0) {
    if (grid[i - 1][j - 1].getState() == State.FILLED) {
        return true;
      }
  }
  if (i + 1 < gridSizeY && j - 1 >= 0) {
    if (grid[i + 1][j - 1].getState() == State.FILLED) {
        return true;
      }
  }
  if (i - 1 >= 0 && j + 1 < gridSizeX) {
    if (grid[i - 1][j + 1].getState() == State.FILLED) {
        return true;
      }
  }
  if (i + 1 < gridSizeY && j + 1 < gridSizeX) {
    if (grid[i + 1][j + 1].getState() == State.FILLED) {
        return true;
      }
  }
  return false;
}

// Do one step of the Dielectric Breakdown Model algorithm
void stepDBM() {
  Cell addedCell = selectCandidate();
  addedCell.setState(State.FILLED);
  pattern.add(addedCell);
  candidates.remove(addedCell);
  
  updateCandidatePotentials(addedCell);
  int newCandidatesStartIndex = candidates.size();
  findNewCandidates(addedCell);
  calculateNewCandidatePotentials(newCandidatesStartIndex);
}

// Sets initial candidates from seed and calculates potentials
void initalizeDBM() {
  candidates = new ArrayList<Cell>();
  
  Cell seed = pattern.get(0);
  int seedI = seed.getI();
  int seedJ = seed.getJ();
  
  for (int i = -1; i <= 1; i = i + 1) {
    for (int j = -1; j <= 1; j = j + 1) {
      if (i != 0 || j != 0) {
        Cell candidate = grid[seedI + i][seedJ + j];
        candidate.setState(State.CANDIDATE);
        candidates.add(candidate);
      }
    }
  }
  
  updateCandidatePotentials(seed);
}

// Updates each candidate's potential based on the cells in the pattern.
void updateCandidatePotentials(Cell addedCell) {
  for (Cell candidate : candidates) {
    int candidateI = candidate.getI();
    int candidateJ = candidate.getJ();
    int addedCellI = addedCell.getI();
    int addedCellJ = addedCell.getJ();
    float dist = calcDist(candidateI, candidateJ, addedCellI, addedCellJ);
    
    float currPotential = candidate.getPotential();
    float potentialToAdd = 1 - (1 / dist);
    candidate.setPotential(currPotential + potentialToAdd);
  }
}

// Calculates the distance between a candidate and an added cell in the pattern.
float calcDist(int candidateI, int candidateJ, int addedCellI, int addedCellJ) {
  float iDiff = (candidateI - addedCellI);
  float jDiff = (candidateJ - addedCellJ);
  return sqrt((iDiff * iDiff) + (jDiff * jDiff));
}

// Selects a candidate from the candidate list based on potentials to be added
// to the pattern.
Cell selectCandidate() {
  
  float minPotential = candidates.get(0).getPotential();
  float maxPotential = candidates.get(0).getPotential();
  for (Cell candidate : candidates) {
    float potential = candidate.getPotential();
    if (potential < minPotential) {
      minPotential = potential;
    }
    if (potential > maxPotential) {
      maxPotential = potential;
    }
  }
  
  float potentialRange = maxPotential - minPotential;
  float PhiIEtaSum = 0;
  for (Cell candidate : candidates) {
    float potential = candidate.getPotential();
    float Phi_i = (potential - minPotential) / potentialRange;
    float Phi_i_eta = pow(Phi_i, eta);
    PhiIEtaSum += Phi_i_eta;
    candidate.setPhiIEta(Phi_i_eta);
  }
  
  for (Cell candidate : candidates) {
    float Phi_i_eta = candidate.getPhiIEta();
    candidate.setPI(Phi_i_eta / PhiIEtaSum);
  }
  
  float partialSum = 0;
  for (Cell candidate : candidates) {
    partialSum += candidate.getPI();
    candidate.setPartialSumI(partialSum);
  }
  
  float selectionChance = random(1);
  Cell selectedCell = candidates.get(0);
  for (Cell candidate : candidates) {
    float partialSumI = candidate.getPartialSumI();
    if (selectionChance < partialSumI) {
      selectedCell = candidate;
      return selectedCell;
    }
  }
  
  return selectedCell;
}

// Adds the new candidates from the newest cell added to the pattern.
void findNewCandidates(Cell addedCell) {

  int addedCellI = addedCell.getI();
  int addedCellJ = addedCell.getJ();
  
  if (addedCellI - 1 >= 0) {
    Cell candidate = grid[addedCellI - 1][addedCellJ];
    checkCandidate(candidate);
  }
  if (addedCellI + 1 < gridSizeY) {
    Cell candidate = grid[addedCellI + 1][addedCellJ];
    checkCandidate(candidate);
  }
  if (addedCellJ - 1 >= 0) {
    Cell candidate = grid[addedCellI][addedCellJ - 1];
    checkCandidate(candidate);
  }
  if (addedCellJ + 1 < gridSizeX) {
    Cell candidate = grid[addedCellI][addedCellJ + 1];
    checkCandidate(candidate);
  }
  if (addedCellI - 1 >= 0 && addedCellJ - 1 >= 0) {
    Cell candidate = grid[addedCellI - 1][addedCellJ - 1];
    checkCandidate(candidate);
  }
  if (addedCellI + 1 < gridSizeY && addedCellJ - 1 >= 0) {
    Cell candidate = grid[addedCellI + 1][addedCellJ - 1];
    checkCandidate(candidate);
  }
  if (addedCellI - 1 >= 0 && addedCellJ + 1 < gridSizeX) {
    Cell candidate = grid[addedCellI - 1][addedCellJ + 1];
    checkCandidate(candidate);
  }
  if (addedCellI + 1 < gridSizeY && addedCellJ + 1 < gridSizeX) {
    Cell candidate = grid[addedCellI + 1][addedCellJ + 1];
    checkCandidate(candidate);
  }
  
}

// Checks a potential candidate to see if it is an EMPTY state
// and adds it to the candidate list.
void checkCandidate(Cell candidate) {
  if (candidate.getState() == State.EMPTY) {
    candidate.setState(State.CANDIDATE);
    candidates.add(candidate);
  }
}

// Calculates the potentials for the newly added candidates
void calculateNewCandidatePotentials(int startIndex) {
  for (int n = startIndex; n < candidates.size(); n++) {
    Cell newCandidate = candidates.get(n);
    int candidateI = newCandidate.getI();
    int candidateJ = newCandidate.getJ();
    float potentialSum = 0;
    for (Cell patternCell : pattern) {
      int patternI = patternCell.getI();
      int patternJ = patternCell.getJ();
      float dist = calcDist(candidateI, candidateJ, patternI, patternJ);
      potentialSum += 1 - (1 / dist);
    }
    newCandidate.setPotential(potentialSum);
  }
}
