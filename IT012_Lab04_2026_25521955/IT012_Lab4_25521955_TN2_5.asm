# Ho Ten: Le Quoc Trung, mssv: 25521955
# Muc dich: viet duoc ham phan bac gia lap if else
# Ma nguon 5 – phan bac dien nang

.data

prompt: .asciiz "Nhap dien nang (kWh): "

msg:    .asciiz "Bac\ "

nl:     .asciiz "\n"

 

.text

.globl main

main:
  li  $v0, 4
  la  $a0, prompt
  syscall
  li  $v0, 5            # doc kWh, ket qua o $v0
  syscall
  add $s0, $v0, $zero   # $s0 = dien nang (kWh)
  # >>> xac dinh bac (1..4) theo Bang 6, dat vao $s1
  slti $t0, $s0,101
  bne $t0, $zero, Bac1
  slti $t0, $s0,151
  bne $t0, $zero, Bac2
  slti $t0, $s0, 201
  bne $t0, $zero, Bac3
  j Bac4
  Bac1:
  	addi $t1, $zero, 1
  	j InBac
  Bac2:
  	addi $t1, $zero, 2
  	j InBac
  Bac3:
  	addi $t1, $zero, 3
  	j InBac
  Bac4:
  	addi $t1, $zero, 4
  # >>> in “Bac: “, roi $s1, roi xuong dong
  InBac:
  	li $v0, 4
  	la $a0, msg
  	syscall
  	
  	li $v0, 1
  	move $a0, $t1
  	syscall
  	
  	li $v0 , 4
  	la $a0, nl
  	syscall
  	
  li  $v0, 10

  syscall

