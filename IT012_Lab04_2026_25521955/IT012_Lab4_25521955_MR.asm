# Ho Ten: Le Quoc Trung, mssv: 25521955
# Muc dich: Tinh tong cua tung bac
# Ma nguon MR
# thanh ghi:
# $s0 = dia chi nen reading     $s1 = dia chi nen usage
# $s2 = i                       $s3 = n
# $s4 = dia chi nen cnt         $s5 = gia tri cnt[k] dang cap nhat
# $t0 = ket qua slti            $t1 = 4*i
# $t2 = dia chi phan tu         $t3 = gia tri doc duoc
# $t4 = so hieu bac (0..3)      $t5 = do doi cua cnt / gia tri in
# $t6 = dia chi phan tu usage hoac cnt
.data
m1:      .asciiz "Bac "
m2:      .asciiz ": "
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955

         .word 2210, 2440, 2625, 2775, 2895, 2995

usage:   .space 48
cnt: 	 .word 0, 0, 0, 0

# Ma nguon MR – bac tung thang
.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  la   $s1, usage       # $s1 = dia chi nen usage
  addi $s2, $zero, 0    # i = 0
  addi $s3, $zero,12    # n = 12 thang
  
  	
# --- Tinh dien nang tung thang vao usage ---
Loop:
  # >>> thoat neu i == n
	beq $s2,$s3, Done
	sll $t1, $s2, 2  	# $t1 = i *4
	add $t2, $s0, $t1 	# dia chi cua reading[i]
	lw $t3, 0($t2)		# $t3 = reading i
	lw $t4 ,4($t2) 		# $t4 = reading i + 1
	sub $t5, $t4, $t3	# dien nang thagn i
 	add $t6, $s1, $t1	# dia chi usago i
	sw $t5, 0($t6)		# $t5 = usago i
	addi $s2,$s2, 1		#i++
	j Loop
Done:
# --- Phan bac va dem vao cnt --- 	
	addi $s2, $zero, 0    # i = 0
  	addi $s3, $zero,12	#n = 12
  	la 	$s4, cnt
Loop1:
	beq $s2,$s3, Done1
   	sll $t1, $s2, 2       # $t1 = i *4
   	add $t2, $s1, $t1     # dia chi cua usage[i]
   	lw $t3, 0($t2)        # $t3 = usage i

    	slti $t0, $t3,101	# muc bac 1
    	bne $t0, $zero, Bac1
   	slti $t0, $t3,151	# muc bac 2
     	bne $t0, $zero, Bac2
     	slti $t0, $t3, 201	# muc bac 3
	bne $t0, $zero, Bac3
      	j Bac4			# muc bac 4
  Bac1:
      	addi $t4, $zero, 0
      	j Update
  Bac2:
      	addi $t4, $zero, 1
      	j Update
  Bac3:
      	addi $t4, $zero, 2
      	j Update
  Bac4:
      	addi $t4, $zero, 3
  
  Update:
      	sll $t5, $t4, 2      # $t5 = i * 4
    	add $t6, $s4, $t5     # dia chi cua cnt[i] 
    	lw $s5, 0($t6)        # lay tong cua bac
    	addi $s5, $s5,1        # cong 1 
    	sw  $s5, 0($t6)        # luu lai vao cnt
  
    addi $s2,$s2, 1        #i++
    j Loop1
 Done1:
# --- In ket qua ---
 	addi $s2, $zero, 0   	# i = 0
  	addi $s3, $zero, 4	# n = 4
Loop2:
 	beq $s2,$s3, Exit
    sll $t1, $s2, 2      # $t1 = i *4
    add $t2, $s4, $t1     # dia chi cua cnt[i]
    lw $t3, 0($t2)        # $t3 = cnt[i]

    li $v0, 4
    la $a0, m1 
    syscall            #output "Bac "
    addi $t5,$s2,1
    li $v0, 1
    move $a0, $t5        
    syscall            #output "Bac <k>"
    li $v0, 4
    la $a0, m2 
    syscall            #output "Bac <k>:"
    li $v0, 1
    move $a0, $t3        
    syscall            #output "Bac <k>: <tong>"
    li $v0, 4
    la $a0, nl     
    syscall            #new line
    addi $s2,$s2, 1        #i++
    j Loop2
Exit:    
  li   $v0, 10

  syscall

