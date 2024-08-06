# Linked List Program

<p>This assembly language program creates a linked list of product structs for an inventory control system. It prompts the user for product details (ID, name, price, cost, quantity), stores them in a dynamically allocated linked list, and then outputs the inventory details.</p>

### Program Overview
<p>The program performs the following tasks:</p>
<ul>
    <li>Prompts the user to enter product details until an end-of-file signal (ctrl-d) is received.</li>
    <li>Stores the entered product details in a dynamically allocated linked list of structs.</li>
    <li>Prints the current inventory details.</li>
</ul>

### Compile and Run the Program
<p>To compile and run the program, follow these steps in your terminal:</p>
<b>Assemble the Program</b>:
<pre><code>nasm -f elf64 LinkedList.asm -o LinkedList.o</code></pre>
<b>Link the Program</b>:

<pre><code>ld LinkedList.o -o LinkedList</code></pre>
<b>Run the Program</b>:

<pre><code>./LinkedList</code></pre>

### Usage
<p>1. The program starts by prompting the user to enter product details:</p>
<ul>
    <li>Displays the message "Welcome to Smith's Seed Inventory Control System!"</li>
</ul>
<p>2. The user inputs product details, which are stored in a dynamically allocated linked list of structs:</p>
<ul>
    <li>Each product has an ID, name, price, cost, and quantity.</li>
</ul>
<p>3. The program prints the current inventory details:</p>
<ul>
    <li>Displays the product ID, name, price, cost, and quantity for each product in the inventory.</li>
</ul>

### Contributor
<p>Lawrence Menegus</p>
