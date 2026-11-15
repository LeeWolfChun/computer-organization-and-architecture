# Ho Ten: Le Quoc Trung, mssv: 25521955
# Muc dich: tinh dien nang tung thang, tong ca nam va thang tieu thu cao nhat
# Ma nguon 7
# Thanh ghi: $s0 reading, $s1 usage, $s2 = i , $s3 = n , $s4 = tong dien nang , 
#	     $s5 = dien nang max , $s6 = thang max 
#            $t1 = 4 * i , $t2 =  &reading[i] , $t3 = reading[i], $t4 = reading[i+1]
#	     $t5 = dien nang thang i ,$t6 = &usago[i], $t7 = 1 n
.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955

         .word 2210, 2440, 2625, 2775, 2895, 2995

usage:   .space 48

# Ma nguon 8 – dien nang tung thang
.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  
  la   $s1, usage       # $s1 = dia chi nen usage
  addi $s2, $zero, 0    # i = 0
  addi $s3, $zero,12    # n = 12 thang
  addi $s4, $zero, 0	# tong dien nang 
  addi $s5, $zero, 0	# dien nang max
  addi $s6, $zero, 0	# thang maxS
  
Loop:
  # >>> thoat neu i == n
	beq $s2,$s3, Done
	sll $t1, $s2, 2  	# $t1 = i *4
	add $t2, $s0, $t1 	# dia chi cua reading[i]
	lw $t3, 0($t2)		# $t3 = reading i
	lw $t4 4($t2) 		# $t4 = reading i + 1
	sub $t5, $t4, $t3	# dien nang thagn i
 	add $t6, $s1, $t1	# dia chi usago i
	sw $t5, 0($t6)		# $t5 = usago i
	add $s4, $s4, $t5	# cong tong dien nang
	slt $t7, $s5, $t5	# $t7 = 1 neu dien max < thang i
	beq $t7, $zero, NoMax	# neu nho hon -> 0 den NoMax
	move $s5,$t5		# cap nhat dien nang max
	addi $s6,$s2,1		# cap nhat thang max
NoMax: 
	li $v0, 4
	la $a0, m1 
	syscall 	 	#output "Thang "
	li $v0, 1
	addi $a0, $s2 ,1 
	syscall			#output "Thang i"
	li $v0, 4
	la $a0, m2 	
	syscall			#output "Thang i:"
	li $v0, 1
	move $a0, $t5	
	syscall			#output "Thang i: [tien thang i]"
	li $v0, 4
	la $a0, nl 	
	syscall			#new line
  # >>> i = i + 1, quay lai Loop
	addi $s2,$s2, 1		#i++
	j Loop
	
Done:
	li $v0, 4
	la $a0, mt 
	syscall			#output "Tong: "
	li $v0, 1
	move $a0, $s4		
	syscall			#output "Tong: <tong>"
	li $v0, 4
	la $a0, nl 	
	syscall			#new line
	li $v0, 4
	la $a0, mm 			
	syscall			#output "Thang cao nhat: "
	li $v0, 1
	move $a0, $s6		 
	syscall			#output "Thang cao nhat: <thang>"
	li $v0, 4
	la $a0, lp 
	syscall			#output "Thang cao nhat: <thang> ("
	li $v0, 1
	move $a0, $s5		 
	syscall			#output "Thang cao nhat: <thang> (<dien nang>"
	li $v0, 4
	la $a0, rp 
	syscall			#output "Thang cao nhat: <thang> (<dien nang>)"
	li $v0, 4
	la $a0, nl 	
	syscall			#new line
  li   $v0, 10

  syscall

