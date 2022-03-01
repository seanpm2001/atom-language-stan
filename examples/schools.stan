data {
  int<lower=0> N;
  vector[N] y;
  vector[N] sigma_y;
}
parameters {
  vector[N] eta;
  real mu_theta;
  real<lower=0,upper=100> sigma_eta;
  real xi;
  array[3] real unused;
}
transformed parameters {
  real<lower=0> sigma_theta;
  vector[N] theta;
  theta = mu_theta + xi * eta;
  sigma_theta = fabs(xi) / sigma_eta;
}
model {
  mu_theta ~ normal(0, 100);
  target += inv_gamma(sigma_eta | 1, 1); //prior distribution can be changed to uniform
  target += normal(eta | 0, sigma_eta);
  target += normal(xi | 0, 5);
  target += normal(y | theta,sigma_y);
}

generated quantities {
   complex z = 3i - 1e4i + 4.3i;
}
