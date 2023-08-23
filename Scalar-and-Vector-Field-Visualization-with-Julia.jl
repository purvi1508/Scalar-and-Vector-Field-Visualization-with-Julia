import Pkg; Pkg.add("CalculusWithJulia")

using CalculusWithJulia, Plots

h(x,y) = 200 - x^2 -2*y^2

surface(-1:0.1:1, -1:0.1:1, h)

x = range(-1, 1, length=100)
y = range(-1, 1, length=50)
z = @. h(x', y)
contour(x, y, z)
#' in the line defining z
# z = @. f(x', y) will broadcast the function f over x' and y and yield a matrix of size (50, 100).

using SymPy

gr()  # better arrows

h(x,y) = 200 - x^2 - 2y^2
h(v) = h(v...)

xs = ys = range(-20,20, length=50)

p = contour(xs, ys, h, nlevels=5)
vectorfieldplot!(p, gradient(h), xlim=(-20,20), ylim=(-20,20), nx=10, ny=10)


f(x,y)=[x,y]
f(v)=f(v...)

vectorfieldplot(f, gradient(h), xlim=(-20,20), ylim=(-20,20), nx=10, ny=15)

using ForwardDiff
using Plots

h(x, y) = 200 - x^2 - 2y^2

dh_dx = (x, y) -> ForwardDiff.derivative(z -> h(z, y), x)
dh_dy = (x, y) -> ForwardDiff.derivative(z -> h(x, z), y)

x_range = -1:0.1:1
y_range = -1:0.1:1

grad_x = zeros(length(x_range), length(y_range))
grad_y = zeros(length(x_range), length(y_range))

for (i, x) in enumerate(x_range)
    for (j, y) in enumerate(y_range)
        grad_x[i, j] = dh_dx(x, y)
        grad_y[i, j] = dh_dy(x, y)
    end
end


p1= contour(x_range, y_range, grad_x', levels=15, color=:plasma, xlabel="x", ylabel="y", title="Gradient dh/dx")
#is a plotting command that uses the Plots library in Julia to create a contour plot for the gradient component grad_x.


p2= contour(x_range, y_range, grad_y', levels=15, color=:viridis, xlabel="x", ylabel="y", title="Gradient dh/dy")
# is another plotting command using the Plots library in Julia. This one creates a contour plot for the gradient component grad_y.

xs = range(-20, stop=20, length=10)
ys = range(-20, stop=20, length=10)

p3 = contour(xs, ys, h, nlevels=5)

p4 = plot(xlims=(-20, 20), ylims=(-20, 20), xlabel="x", ylabel="y", legend=false)
for x in xs, y in ys
    grad = [dh_dx(x, y), dh_dy(x, y)]
    quiver!(p4, [x], [y], quiver=[grad[1], grad[2]], color=:blue, alpha=0.6)
end

plot(p3, p4, layout=(1, 2))

H(x,y)=[exp(x)*y^2,(x+2y)]

vectorfieldplot(H, xlim=(-20,20), ylim=(-20,20))

using CalculusWithJulia
using SymPy
using Plots

# Define the symbolic variables
@vars x y

# Define the vector field components
F = [exp(x) * y^2, x + 2y]

# Calculate the divergence
div_xy = divergence(F, [x, y])
div_yx = divergence(F, [y, x])

# Define the range for x and y values
x_vals = -5:0.1:5
y_vals = -5:0.1:5

# Create a grid of x and y values for div_xy
div_xy_values = [N(div_xy.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]

# Create a grid of x and y values for div_yx
div_yx_values = [N(div_yx.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]


# Create a contour plot for div_xy
contour(x_vals, y_vals, div_xy_values, levels=20, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Divergence (div_xy)")


# Create a contour plot for div_xy
contour(x_vals, y_vals, div_yx_values, levels=20, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Divergence (div_yx)")


# Create a 3D surface plot for div_xy
surface(x_vals, y_vals, div_xy_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Divergence", title="3D Surface Plot - Divergence (div_xy)")


# Create a 3D surface plot for div_xy
surface(x_vals, y_vals, div_yx_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Divergence", title="3D Surface Plot - Divergence (div_yx)")


using SymPy

# Define the symbolic variables
@vars x y

# Define the vector field components
F = [exp(x) * y^2, x + 2y]

# Calculate the partial derivatives
∂F₁_∂x = diff(F[1], x)
∂F₂_∂y = diff(F[2], y)

# Calculate the divergence
div_F = ∂F₁_∂x + ∂F₂_∂y

# Display the calculated partial derivatives
println("Partial derivative of F₁ with respect to x: ", ∂F₁_∂x)
println("Partial derivative of F₂ with respect to y: ", ∂F₂_∂y)

# Display the calculated divergence
println("Divergence of the vector field F: ", div_F)


# Define the range for x and y values
x_vals = -5:0.1:5
y_vals = -5:0.1:5

# Evaluate partial derivatives and divergence at each point
∂F₁_∂x_values = [N(∂F₁_∂x.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]
∂F₂_∂y_values = [N(∂F₂_∂y.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]
div_F_values = [N(div_F.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]

# Create contour plots for partial derivatives and divergence
contour(x_vals, y_vals, ∂F₁_∂x_values, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Partial Derivative ∂F₁/∂x")
contour(x_vals, y_vals, ∂F₂_∂y_values, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Partial Derivative ∂F₂/∂y")
contour(x_vals, y_vals, div_F_values, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Divergence (div_xy)")

# Create 3D surface plots for partial derivatives and divergence
surface(x_vals, y_vals, ∂F₁_∂x_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Partial Derivative ∂F₁/∂x", title="3D Surface Plot - Partial Derivative ∂F₁/∂x")
surface(x_vals, y_vals, ∂F₂_∂y_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Partial Derivative ∂F₂/∂y", title="3D Surface Plot - Partial Derivative ∂F₂/∂y")
surface(x_vals, y_vals, div_F_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Divergence", title="3D Surface Plot - Divergence (div_xy)")

# Define the vector field components
F = [exp(x) * y^2, x + 2y]

# Calculate the partial derivatives
∂F₁_∂y = diff(F[1], y)
∂F₂_∂x = diff(F[2], x)

# Calculate the divergence
div_F = ∂F₁_∂y + ∂F₂_∂x

# Display the calculated partial derivatives
println("Partial derivative of F₁ with respect to y: ", ∂F₁_∂y)
println("Partial derivative of F₂ with respect to x: ", ∂F₂_∂x)

# Display the calculated divergence
println("Divergence of the vector field F: ", div_F)

# Define the range for x and y values
x_vals = -5:0.1:5
y_vals = -5:0.1:5

# Evaluate partial derivatives and divergence at each point
∂F₁_∂y_values = [N(∂F₁_∂y.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]
∂F₂_∂x_values = [N(∂F₂_∂x.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]
div_F_values = [N(div_F.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]

# Create contour plots for partial derivatives and divergence
contour(x_vals, y_vals, ∂F₁_∂y_values, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Partial Derivative ∂F₁/∂y")
contour(x_vals, y_vals, ∂F₂_∂x_values, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Partial Derivative ∂F₂/∂x")
contour(x_vals, y_vals, div_F_values, color=:viridis, xlabel="x", ylabel="y", title="Contour Plot - Divergence (div_yx)")

# Create 3D surface plots for partial derivatives and divergence
surface(x_vals, y_vals, ∂F₁_∂y_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Partial Derivative ∂F₁/∂y", title="3D Surface Plot - Partial Derivative ∂F₁/∂y")
surface(x_vals, y_vals, ∂F₂_∂x_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Partial Derivative ∂F₂/∂x", title="3D Surface Plot - Partial Derivative ∂F₂/∂x")
surface(x_vals, y_vals, div_F_values, color=:viridis, xlabel="x", ylabel="y", zlabel="Divergence", title="3D Surface Plot - Divergence (div_yx)")

using CalculusWithJulia
using SymPy
using Plots

# Define the symbolic variables
@vars x y

# Define the vector field components
F = [exp(x) * y^2, x + 2y]

# Calculate the curl with respect to x and y
curl_x = curl(F, [x, y])

# Define the range for x and y values
x_vals = -5:0.1:5
y_vals = -5:0.1:5

# Create a grid of x and y values for curl_x
curl_x_values = [N(curl_x.subs([(x, xv), (y, yv)])) for xv in x_vals, yv in y_vals]


# Create contour plots for both components of the curl
contour(x_vals, y_vals, curl_x_values, xlabel="x", ylabel="y", title="Curl (x component)", fill=true, color=:viridis)

# Create 3D surface plots for both components of the curl
surface(x_vals, y_vals, curl_x_values, xlabel="x", ylabel="y", zlabel="Curl (x component)", title="Curl (x component)")

using Plots
using ForwardDiff

# Define the vector field components as a function named "my_vector_field"
function vector_field(x, y)
    f = exp(x) * y^2
    g = x + 2y
    return [f, g]
end

df_dx_derivative(x, y) = ForwardDiff.derivative(f -> my_vector_field(x, f)[1], y)
df_dy_derivative(x, y) = ForwardDiff.derivative(g -> my_vector_field(g, y)[2], x)

# Calculate the curl components
calculate_curl_x(x, y) =  df_dy_derivative(x, y) - df_dx_derivative(x, y)

# Define the range for x and y values
x_vals = -5:0.1:5
y_vals = -5:0.1:5

# Calculate curl values over the range
curl_values = [(calculate_curl_x(x, y), calculate_curl_y(x,y)) for x in x_vals, y in y_vals]

# Extract curl x and y components for plotting
curl_x_vals = [curl[1] for curl in curl_values]




# Create a contour plot
contour(x_vals, y_vals, curl_x_vals, xlabel="x", ylabel="y", title="Curl x-component", fill=true, color=:viridis)

surface(x_vals, y_vals, curl_x_vals, xlabel="x", ylabel="y", zlabel="Curl x-component", title="Surface Plot: Curl x-component")


