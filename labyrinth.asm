# Return address at: 0x00
# Consts:
#    - move forward:   0x04
#    - turn left:      0x08
#    - turn right:     0x10
#    - obstacle:       0x100
#    - turning|moving: 0x600

main:
  # Wait until stops moving then return to "main2"
  A = main2
  D = A
  A = 0
  *A = D
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

  # Set return address to "main"
  A = 0
  *A = main
  
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
  # Set return address to main
  A = main
  D = A
  A = 0
  *A = D
  # Wait for the turn to finish and back to main2
  A = wait
  JMP


move:
  # Command to move forward
  A = 0x4
  D = A
  A = 0x7fff
  *A = D
  # Set return address to main
  A = main
  D = A
  A = 0
  *A = D
  # Wait for the move to finish
  A = wait
  JMP

wait:
  # Check if turning or moving is in progress
  A = 0x7fff
  D = *A
  A = 0x600
  D = D & *A
  # Retrieve return address from 0x00
  A = 0
  A = *A
  # If not turning/moving, jump back to return address
  D ; JEQ
  # Otherwise wait again
  A = wait
