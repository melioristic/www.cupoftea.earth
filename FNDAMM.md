+++
title = "DAMM Fluxnet"
+++

# DAMM model fitted to FLUXNET sites

```julia:ex
#hideall
using WGLMakie, JSServe, UnicodeFun, SparseArrays, LsqFit
io = IOBuffer()
println(io, "~~~")
show(io, MIME"text/html"(), Page(exportable=true, offline=true))

include(joinpath("functions", "FLUXNET", "load.jl"))
ID = getID()[1] # should be called in functions that needs it instead of global
include(joinpath("functions", "quantilebins.jl")) # could be a new Julia package
include(joinpath("functions", "DAMMfit_2.jl")) # could be added to DAMMmodel.jl
include(joinpath("functions", "DAMM_scaled_porosity_3.jl")) # would be better to use package
include(joinpath("functions", "FLUXNET", "FNDAMMfit.jl"))
include(joinpath("functions", "FLUXNET", "FNDAMMplot.jl"))

# write new script or add more code in existing scripts:
# 1. filter FLUXNET data, only keep qc measurement (no gap-fill)
# 2. get only dataset that contain variables we need (Ts, M, R)
# 3. normalize (max resp = 10, M from 0 to 100, etc.)

app = App() do session::Session    
	# slider = JSServe.Slider([1, 3, 4, 5]) # not implemented right now, later
	slider = JSServe.Slider(3:6)
	fig = FNDAMMplot(slider)[1]
	site = FNDAMMplot(slider)[2]
	sl = DOM.div("FLUXNET site: ", slider, slider.value)
	return JSServe.record_states(session, DOM.div(sl, site, fig))
end

# d

show(io, MIME"text/html"(), app)
println(io, "~~~")
println(String(take!(io)))
```
\textoutput{ex}

v0.1.2