;;; Assembly Course
;;; Author: Lawrence Menegus
;;; File: LinkedList.asm
;;; Date: 4/15/23
;;; Description: Create a LinkedList of structs in order and build inventory for a company system that sells seeds for garden plants.

%define EOF -1
%define MAX_BUFFER 255
%define empty 0
    
struc Product
.number: resd 1
.name: resq 1
.price: resd 1
.cost: resd 1
.quantity: resd 1
.redptr: resq 1
.size:
endstruc

segment .data
;; Display Prompts
prompt: db "Welcome to Smith's Seed Inventory Control System!", 0
prompt2: db "Please have a Product Number, Product Name, Price, Cost and Quantity information ready.", 0
promptNumber: db "Enter Product ID:", 0
promptName: db "Enter Product Name:", 0
promptPrice: db "Enter the Price:", 0
promptCost: db "Enter the Cost:", 0
promptQuantity: db "Enter the Quantity:", 0
new: db "", 10, 10, 0

;; Output Prompts
promptResponse: db "Here is the current store inventory:", 0
outputNumber: db "Product ID: %d", 10, 0
outputName: db "Product Name: %s", 10, 0
outputPrice: db "Price: %d", 10, 0
outputCost: db "Cost: %d", 10, 0
outputQuantity: db "Quantity: %d", 10, 0
intFormat: db "%d", 0
strFormat: db "%s", 0

segment .bss
;; Points to head of the linked list
head: resq 1
;; Points to last node
lastNode: resq 1
intInput: resd 1
strInput: resb MAX_BUFFER

segment .text
global asm_main
extern printf, scanf, calloc, free, strncpy, strnlen

asm_main:
    enter 8, 0
    call Input
    ;; Move pointer to linked list's head to rdi
    mov rdi, rax
    call Output
    mov rax, 0
    leave
    ret

Input:
    enter 8, 0
    ;; Clear registers
    xor r8, r8
    xor r12, r12
    xor r13, r13
    xor r14, r14

    ;; Prints out the Initial Greeting
    mov rdi, new
    call printf
    mov rdi, prompt
    call printf
    mov rdi, new
    call printf
    mov rdi, prompt2
    call printf
    mov rdi, new
    call printf

inputLoop:
    push rcx
    push rsi
    ;; Create the head node
    cmp r12, BYTE empty
    jne newNode
    ;; Allocate space for head node of the linked list
    mov rdi, 1
    mov rsi, Product.size
    call calloc
    ;; Move head and last node
    mov r13, rax
    mov r12, rax
    jmp AddtoNode

newNode:
    ;; Allocate space
    mov rdi, 1
    mov rsi, Product.size
    call calloc
    ;; Move lastNode
    mov r14, r12
    mov [r14 + Product.redptr], rax
    mov r12, rax
    jmp AddtoNode

AddtoNode:
    ;; Product Number
    mov rdi, promptNumber
    call printf
    mov rdi, intFormat
    mov rsi, intInput
    call scanf
    ;; If the Control D is pressed, it jumps to end of the input
    cmp eax, EOF
    jne Continue
    ;; Clears the pointer
    ;; r14 holds the previous node
    mov [r14 + Product.redptr], r8
    jmp endInput

Continue:
    ;; Move the value into the struct's location
    mov rax, [intInput]
    mov r8, r12
    mov [r8 + Product.number], eax
    ;; Display to the user to ask for product name
    mov rdi, promptName
    call printf
    ;; Return user input
    mov rdi, strFormat
    mov rsi, strInput
    call scanf
    ;; Get string length
    mov rdi, strInput
    mov rsi, MAX_BUFFER
    call strnlen
    inc rax
    mov r15, rax
    ;; Allocate memory for string
    mov rdi, rax
    mov rsi, 1
    call calloc
    ;; Copy string to node's location
    mov [r12 + Product.name], rax
    mov rdi, rax
    mov rsi, strInput
    mov rdx, r15
    call strncpy
    ;; Product Price
    mov rdi, promptPrice
    call printf
    mov rdi, intFormat
    mov rsi, intInput
    call scanf
    ;; Move the value into struct's location
    mov rax, [intInput]
    mov r8, r12
    mov [r8 + Product.price], eax
    ;; Product Cost
    mov rdi, promptCost
    call printf
    mov rdi, intFormat
    mov rsi, intInput
    call scanf
    mov rax, [intInput]
    mov r8, r12
    mov [r8 + Product.cost], eax
    ;; Product Quantity
    mov rdi, promptQuantity
    call printf
    mov rdi, intFormat
    mov rsi, intInput
    call scanf
    mov rax, [intInput]
    mov r8, r12
    mov [r8 + Product.quantity], eax
    mov rdi, new
    call printf
    pop rsi
    pop rcx
    jmp inputLoop

endInput:
    mov rax, r13
    leave
    ret

Output:
    enter 8, 0
    ;; r12 will point to the node
    mov r12, rdi
    ;; Print out Inventory Prompt
    mov rdi, new
    call printf
    mov rdi, new
    call printf
    mov rdi, new
    call printf
    mov rdi, promptResponse
    call printf
    mov rdi, new
    call printf

outputLoop:
    push rcx
    push rsi
    ;; Print out Inventory
    mov rdi, outputNumber
    mov eax, [r12 + Product.number]
    mov rsi, rax
    call printf
    mov rdi, outputName
    mov rax, [r12 + Product.name]
    mov rsi, rax
    call printf
    mov rdi, outputPrice
    mov eax, [r12 + Product.price]
    mov rsi, rax
    call printf
    mov rdi, outputCost
    mov eax, [r12 + Product.cost]
    mov rsi, rax
    call printf
    mov rdi, outputQuantity
    mov eax, [r12 + Product.quantity]
    mov rsi, rax
    call printf
    mov rdi, new
    call printf
    ;; Move to next node
    mov r12, [r12 + Product.redptr]
    pop rsi
    pop rcx
    jne outputLoop

    leave
    ret