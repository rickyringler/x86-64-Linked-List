brk is a syscall to allocate memory by extending the size of the heap. 
By allocating adjacent memory for new data and the address of the prior node, we can link each node of the container to resize if desired.
***

<img width="312" height="561" alt="image" src="https://github.com/user-attachments/assets/4e8d3235-efe5-4fe8-8076-ba36e2fd4e0c" />

### References I Used
> *brk(2) — Linux manual page*.  
> [Linux Man Pages](https://www.man7.org/linux/man-pages/man2/brk.2.html)

>  *What Does the Brk System Call Do*.  
> [Stack Overflow](https://stackoverflow.com/questions/6988487/what-does-the-brk-system-call-do)
