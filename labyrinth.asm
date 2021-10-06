// The commit history of this file shows different, shorter and shorter solutions.
// Shortest working solution (10 instructions; works only for "Check solution" but not when run):
A = 0x7fff
*A = D
D = *A
A = 8
D ; JEQ
D = A
A = 0
JMP
A = 4
D = A
JMP

  
// Other, longer solution (14 instructions; works with "Run"):
// Uncommented form:
A = 0x8
D = A
A = 0x100
*A = D

A = 0x4
D = A
A = 0
*A = D

main:
  A = 0x7fff
  A = *A
  D = *A
  A = 0x7fff
  *A = D
  A = main
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
  # Do what is stored under address D
  # D can be:
  #   0x00  - if no obstacle
  #   0x100 - has obstacle
  # Proper actions for those situations
  # are hardcoded under those addresses
  # in order to avoid additional branching.
  #   0x00  - no obstacle, move forward = 0x04
  #   0x100 - obstacle, turn right = 0x10
  A = 0x7fff
  A = *A
  D = *A
  A = 0x7fff
  *A = D
  # ... repeat
  A = main
  JMP
