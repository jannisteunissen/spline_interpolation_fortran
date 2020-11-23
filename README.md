# Cubic spline interpolation in Fortran

A module for cubic spline interpolation in Fortran, based on:

* [spline.f](https://www.netlib.org/fmm/spline.f)
* [spline.f90](https://ww2.odu.edu/~agodunov/computing/programs/book2/Ch01/spline.f90),
  a Fortran 90 translation of `spline.f`

## Requirements

A somewhat recent Fortran compiler (`gfortran` is the default compiler in the `Makefile`).

## Usage

Usage looks like this:

    type(spline_t) :: spl

    ! Compute coefficients, n is size of input table
    call spline_set_coeffs(x_table, y_table, n, spl)

    ! Evaluate at x_eval using the elemental function spline_evaluate
    y = spline_evaluate(x_eval, spl)

## Example

See `test.f90`, which can be compiled with:

    make

and executed with for example:

    ./test 100 1000000

which uses a table with 100 points of a cubic function as input, which is then evaluated at 1000000 points using cubic spline interpolation. Example of output:

    Using n_table = 100 and n_eval = 1000000
    Error (L1, L2, Linf):     0.91803402E-16  0.19963740E-15  0.17763568E-14
    Evaluated points/second:  0.92936803E+08

Note that the error is so small here because a cubic spline can 'exactly' approximate a cubic function. For generic function interpolation, errors will be larger.

## TODO

* Implement different types of boundary conditions

## License

This code has the same license as
[spline.f](https://www.netlib.org/fmm/spline.f) and
[spline.f90](https://ww2.odu.edu/~agodunov/computing/programs/book2/Ch01/spline.f90),
which are assumed to be in the public domain.
