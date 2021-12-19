function fitDAMM(Ind_var, Resp)
  lb = [0.0, 0.0, 0.0, 0.0] # params can't be negative, porosity can't be below max M
  ub = [Inf, Inf, Inf, Inf] # porosity can't be above 1
  p_ini = [0.3, 64.0, 1.0, 1.0]
  fit = curve_fit(DAMM, Ind_var, Resp, p_ini, lower=lb, upper=ub)
  params = coef(fit)
  return params
end
