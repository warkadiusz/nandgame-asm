// Uncommented form:
A = 0x10
D = A
A = 0x100
*A = D

A = 0x04
D = A
A = 0
*A = D

main:
  A = 0x100
  D = A
  A = 0x7fff
  D = D & *A

  A = D
  D = *A
  A = 0x7fff
  *A = D
  *A = 0
  A = wait
  JMP

wait:
  A = 0x7fff
  D = *A
  A = 0x600
  D = D & A
  A = main
  D ; JEQ
  A = wait
  JMP



// Commented form:
# Consts:
#    - move forward:   0x04
#    - turn left:      0x08
#    - turn right:     0x10
#    - obstacle:       0x100
#    - turning|moving: 0x200|0x400 = 0x600

# Save "turn right" command at "obstacle" (0x100) address
A = 0x10
D = A
A = 0x100
*A = D

# Save "move forward" command at "no obstacle" (0x00) address
A = 0x04
D = A
A = 0
*A = D

main:
  # Has obstacle?
  A = 0x100
  D = A
  A = 0x7fff
  D = D & *A

  # Do what is stored under address D
  # D can be:
  #   0x00  - if no obstacle
  #   0x100 - has obstacle
  # Proper actions for those situations
  # are hardcoded under those addresses
  # in order to avoid additional branching.
  #   0x00  - no obstacle, move forward = 0x04
  #   0x100 - obstacle, turn right = 0x10
  A = D
  D = *A
  A = 0x7fff
  *A = D
  
  # Reset input
  *A = 0
  
  # ... and wait for the turn/move to finish
  A = wait
  JMP

wait:
  # Check if turning or moving is in progress
  A = 0x7fff
  D = *A
  A = 0x600
  D = D & A
  
  # If not turning or moving, return to main
  A = main
  D ; JEQ
  
  # Otherwise wait again (loop)
  A = wait
  JMP
