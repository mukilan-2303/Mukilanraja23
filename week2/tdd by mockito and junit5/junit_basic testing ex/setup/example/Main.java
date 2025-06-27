package org.example;

public class Main {
    public static void main(String[] args) {


        Calculator calc = new Calculator();
        int sum = calc.add(10, 15);
        System.out.println("10 + 15 = " + sum);
        int sub = calc.subtract(10, 15);
        System.out.println("10 + 15 = " + sub);
        int mul = calc.multiply(10, 15);
        System.out.println("10 + 15 = " + mul);
        int div = calc.divide(10, 15);
        System.out.println("10 + 15 = " + div);



    }
}
