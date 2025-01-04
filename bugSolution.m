The solution for the ARC issue is to avoid unnecessary strong references.  Instead of creating a temporary variable, assign directly to the property:

```objectivec
- (void)someMethod {
    self.myObject = [[MyObject alloc] init];
    // ... some operations using myObject ...
}
```

This ensures that the object's lifespan is correctly managed by ARC.  For `performSelector:withObject:afterDelay:`, the best solution often involves using blocks or Grand Central Dispatch (GCD) for asynchronous tasks, ensuring that the object's lifetime extends past the delay:

```objectivec
- (void)someMethod {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
        if (self.myObject) { // Check for object validity
          [self.myObject doSomething];
        }
    });
}
```

This approach eliminates the risk of accessing a deallocated object. Always check for object validity before using it after a delay.