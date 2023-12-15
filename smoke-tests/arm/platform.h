// Insert a nop instruction (used e.g. to prevent optimizing out code).
static inline void nop() {
  __asm volatile ("nop");
}
