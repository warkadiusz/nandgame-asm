# Return address in D register
# Consts:
#    - move forward:   0x04
#    - turn left:      0x08
#    - turn right:     0x10
#    - obstacle:       0x100
#    - turning|moving: 0x600

main:
  # Wait until stops moving then return to "main2"
  A = wait
  JMP
main2:  
  # Has obstacle?
  A = 0x100
  D = A
  A = 0x7fff
  D = D & *A

  # Reset all move/turn commands
  *A = 0
  
  # If has obstacle, turn right
  A = turn_right
  D ; JGT
  
  # If not, move forward
  A = move
  JMP

turn_right:
  # Command it to turn right
  A = 0x10
  D = A
  A = 0x7fff
  *A = D
  # Wait for the turn to finish and return to main2
  A = wait
  JMP

move:
  # Command to move forward
  A = 0x4
  D = A
  A = 0x7fff
  *A = D
  # Wait for the move to finish and return to main2
  A = wait
  JMP

wait:
  # Check if turning or moving is in progress
  A = 0x7fff
  D = *A
  A = 0x600
  D = D & *A
  # If not turning/moving, jump back to main2
  A = main2
  D ; JEQ
  # Otherwise wait again (loop)
  A = wait
