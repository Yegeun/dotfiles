#!/usr/bin/env python3
"""
Simple example Python script to demonstrate running with uv
"""

def greet(name):
    """Return a greeting message"""
    return f"Hello, {name}!"

def calculate_factorial(n):
    """Calculate factorial of n"""
    if n <= 1:
        return 1
    return n * calculate_factorial(n - 1)

def main():
    print("=== Python Script Running with UV ===")
    print()

    # Test greeting
    print(greet("World"))
    print(greet("Developer"))
    print()

    # Test factorial calculation
    numbers = [5, 7, 10]
    print("Factorial calculations:")
    for num in numbers:
        result = calculate_factorial(num)
        print(f"  {num}! = {result}")
    print()

    print("✓ Script completed successfully!")

if __name__ == "__main__":
    main()
