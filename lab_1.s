	.file	"lab_1.c"
	.text
	.globl	normal
	.type	normal, @function
normal:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm1
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	mulss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L2:
	cmpl	$3, -4(%rbp)
	jle	.L3
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	normal, .-normal
	.globl	sse
	.type	sse, @function
sse:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rcx
#APP
# 14 "lab_1.c" 1
	movups (%rax), %xmm0
movups (%rdx), %xmm1
mulps %xmm1, %xmm0
movups %xmm0, (%rcx)

# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	sse, .-sse
	.globl	get_time
	.type	get_time, @function
get_time:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-32(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movq	-32(%rbp), %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	-24(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC0(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	get_time, .-get_time
	.section	.rodata
	.align 8
.LC9:
	.string	"\320\227\320\260\320\277\321\203\321\201\320\272 \321\202\320\265\321\201\321\202\320\276\320\262 (%d \320\270\321\202\320\265\321\200\320\260\321\206\320\270\320\271)...\n\n"
	.align 8
.LC10:
	.string	"Normal \321\200\320\265\320\267\321\203\320\273\321\214\321\202\320\260\321\202: %f %f %f %f\n"
	.align 8
.LC11:
	.string	"Normal \320\262\321\200\320\265\320\274\321\217:     %.6f \321\201\320\265\320\272\n\n"
	.align 8
.LC12:
	.string	"SSE \321\200\320\265\320\267\321\203\320\273\321\214\321\202\320\260\321\202:    %f %f %f %f\n"
	.align 8
.LC13:
	.string	"SSE \320\262\321\200\320\265\320\274\321\217:        %.6f \321\201\320\265\320\272\n\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, -64(%rbp)
	movss	.LC2(%rip), %xmm0
	movss	%xmm0, -60(%rbp)
	movss	.LC3(%rip), %xmm0
	movss	%xmm0, -56(%rbp)
	movss	.LC4(%rip), %xmm0
	movss	%xmm0, -52(%rbp)
	movss	.LC5(%rip), %xmm0
	movss	%xmm0, -48(%rbp)
	movss	.LC6(%rip), %xmm0
	movss	%xmm0, -44(%rbp)
	movss	.LC7(%rip), %xmm0
	movss	%xmm0, -40(%rbp)
	movss	.LC8(%rip), %xmm0
	movss	%xmm0, -36(%rbp)
	movl	$100000000, -100(%rbp)
	movl	-100(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	call	get_time
	movq	%xmm0, %rax
	movq	%rax, -96(%rbp)
	movl	$0, -108(%rbp)
	jmp	.L9
.L10:
	leaq	-32(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-64(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	normal
	addl	$1, -108(%rbp)
.L9:
	movl	-108(%rbp), %eax
	cmpl	-100(%rbp), %eax
	jl	.L10
	movl	$0, %eax
	call	get_time
	movq	%xmm0, %rax
	movq	%rax, -88(%rbp)
	movsd	-88(%rbp), %xmm0
	subsd	-96(%rbp), %xmm0
	movsd	%xmm0, -80(%rbp)
	movss	-20(%rbp), %xmm0
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movss	-24(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movss	-28(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movss	-32(%rbp), %xmm3
	pxor	%xmm4, %xmm4
	cvtss2sd	%xmm3, %xmm4
	movq	%xmm4, %rax
	movapd	%xmm2, %xmm3
	movapd	%xmm1, %xmm2
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$4, %eax
	call	printf@PLT
	movq	-80(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	call	get_time
	movq	%xmm0, %rax
	movq	%rax, -96(%rbp)
	movl	$0, -104(%rbp)
	jmp	.L11
.L12:
	leaq	-32(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-64(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	sse
	addl	$1, -104(%rbp)
.L11:
	movl	-104(%rbp), %eax
	cmpl	-100(%rbp), %eax
	jl	.L12
	movl	$0, %eax
	call	get_time
	movq	%xmm0, %rax
	movq	%rax, -88(%rbp)
	movsd	-88(%rbp), %xmm0
	subsd	-96(%rbp), %xmm0
	movsd	%xmm0, -72(%rbp)
	movss	-20(%rbp), %xmm0
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movss	-24(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movss	-28(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movss	-32(%rbp), %xmm3
	pxor	%xmm5, %xmm5
	cvtss2sd	%xmm3, %xmm5
	movq	%xmm5, %rax
	movapd	%xmm2, %xmm3
	movapd	%xmm1, %xmm2
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	movl	$4, %eax
	call	printf@PLT
	movq	-72(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC13(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1093567616
	.align 4
.LC1:
	.long	1082130432
	.align 4
.LC2:
	.long	1084227584
	.align 4
.LC3:
	.long	1088421888
	.align 4
.LC4:
	.long	1086324736
	.align 4
.LC5:
	.long	1109393408
	.align 4
.LC6:
	.long	1112014848
	.align 4
.LC7:
	.long	1116471296
	.align 4
.LC8:
	.long	1114636288
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
