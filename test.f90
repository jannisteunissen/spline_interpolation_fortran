! Test cubic spline interpolation by interpolating a cubic polynomial
program test
  use spline_interp

  implicit none
  integer, parameter    :: dp = kind(0.0d0)
  integer               :: n_table ! Size of tabulated data
  integer               :: n_eval  ! Evaluate in this number of points
  real(dp)              :: xmin, xmax
  real(dp), allocatable :: xi(:), yi(:)
  real(dp), allocatable :: xe(:), ye(:), ys(:)
  real(dp)              :: dx, errors(3), t0, t1
  integer               :: i, n_args
  type(spline_t)        :: spl
  character(len=20)     :: argv

  n_args = command_argument_count()
  if (n_args /= 2) stop "usage: ./test n_table n_eval"

  call get_command_argument(1, argv)
  read(argv, *) n_table
  call get_command_argument(2, argv)
  read(argv, *) n_eval

  write(*, '(A,I0,A,I0)') "Using n_table = ", n_table, &
       " and n_eval = ", n_eval

  allocate(xi(n_table), yi(n_table))
  allocate(xe(n_eval), ye(n_eval), ys(n_eval))

  xmin = -2.0_dp
  xmax = 2.0_dp
  dx   = (xmax - xmin) / (n_table-1)

  ! Set x coordinates
  xi = [(xmin + (i-1) * dx, i = 1, n_table)]

  ! Set y coordinates
  yi = f(xi)

  ! Compute spline coeficients
  call spline_set_coeffs(xi, yi, n_table, spl)

  ! Evaluate at linearly spaced points
  dx = (xmax-xmin)/(n_eval-1)
  xe = [(xmin + (i-1) * dx, i = 1, n_eval)]

  ! Use random points
  ! call random_number(xe)
  ! xe = xmin + (xmax-xmin) * xe

  ye = f(xe)

  call cpu_time(t0)
  ys = spline_evaluate(xe, spl)
  call cpu_time(t1)

  errors(1) = sum(abs(ys-ye))/n_eval
  errors(2) = norm2(ys-ye)/sqrt(real(n_eval, dp))
  errors(3) = maxval(abs(ys-ye))
  write(*, '(A, 3E16.8)') 'Error (L1, L2, Linf):   ', errors
  write(*, '(A, 1E16.8)') 'Evaluated points/second:', n_eval/(t1-t0)

contains

  elemental real(dp) function f(x)
    real(dp), intent(in) :: x
    f = 0.1_dp * (1 + 2*x + 3*x**2 + 4*x**3)
  end function f

end program test
