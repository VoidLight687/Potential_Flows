% Run the script to start the applet and follow the prompts 
% as they appear in the command window.
clear
clc
close all
% Unifrom flow
grids = linspace(-5,5);
[x,y] = meshgrid(grids);
alpha = 0;
V = 5;
z = x + i*y;
u_flow = V*exp(-i*alpha)*z;
xpoint = [];
ypoint = [];

phi_total = zeros(size(z)); % Initialize storage for all real data
psi_total = zeros(size(z)); % Initialize storage for all imaginary data

addMoreFlows = 'Y';
while strcmpi(addMoreFlows, 'Y')
flow_input = input('Please enter source,sink, vortex, or doublet: ','s');
switch flow_input
    case {'source', 'sink'}
% Sources and Sinks
% m indicates the strength, z is the singularity, and z_0 is the origin
grids = linspace(-5,5);
[x,y] = meshgrid(grids);
z = x + i*y;
x_0 = input("Enter a x coordinate between -5 & 5: ");
y_0 = input("Enter a y coordinate between -5 & 5: ");
z_0 = x_0 + i*y_0;
m = input("Enter the source/sink strength: ");
xpoint(end+1) = x_0;
ypoint(end+1) = y_0;
sos = m/(2*pi)*log(z  -z_0);
psi_total = psi_total + imag(sos);
prompt = "Would you like to add another coordinate? Y/N: ";
txt = input(prompt,"s");
while strcmpi(txt, 'Y')
    x_0 = input("Enter a x coordinate between -5 & 5: ");
    y_0 = input("Enter a y coordinate between -5 & 5: ");
    z_0 = x_0 + i*y_0;
    m = input("Enter the source/sink strength: ");
    sos = m/(2*pi)*log(z  -z_0);
    % phi_total = phi_total + real(sos); % real part
    psi_total = psi_total + imag(sos); % imaginary part
    xpoint(end+1) = x_0;
    ypoint(end+1) = y_0;
    prompt = "Would you like to add another coordinate? Y/N: ";
    txt = input(prompt,"s");
end
case 'vortex'
% vortex
grids = linspace(-5,5);
[x,y] = meshgrid(grids);
z = x + i*y;
x_0 = input("Enter a x coordinate between -5 & 5: ");
y_0 = input("Enter a y coordinate between -5 & 5: ");
z_0 = x_0 + i*y_0;
gamma = input("Enter the vortex strength: ");
xpoint(end+1) = x_0;
ypoint(end+1) = y_0;
vortex = (-i*gamma)/(2*pi)*log(z - z_0);
psi_total = psi_total + imag(vortex);
prompt = "Would you like to add another coordinate? Y/N: ";
txt = input(prompt,"s");
while strcmpi(txt, 'Y')
    x_0 = input("Enter a x coordinate between -5 & 5: ");
    y_0 = input("Enter a y coordinate between -5 & 5: ");
    z_0 = x_0 + i*y_0;
    gamma = input("Enter the vortex strength: ");
    vortex = (-i*gamma)/(2*pi)*log(z - z_0);
    % phi_total = phi_total + real(vortex); % real part
    psi_total = psi_total + imag(vortex); % imaginary part
    xpoint(end+1) = x_0;
    ypoint(end+1) = y_0;
    prompt = "Would you like to add another coordinate? Y/N: ";
    txt = input(prompt,"s");
end
case 'doublet'
% Doublets 
grids = linspace(-5,5);
[x,y] = meshgrid(grids);
z = x + i*y;
x_0 = input("Enter a x coordinate between -5 & 5: ");
y_0 = input("Enter a y coordinate between -5 & 5: ");
z_0 = x_0 + i*y_0;
xpoint(end+1) = x_0;
ypoint(end+1) = y_0;
X = x - x_0;
Y = y - y_0;
r = sqrt(X.^2 + Y.^2);
theta = atan2(Y,X);
mu = input('Enter the doublet strength: ');
doublet_equip = -mu./(r).*cos(theta);
doublet_stream = -mu./(r).*sin(theta);
phi_total = phi_total + doublet_equip; % real part
psi_total = psi_total + doublet_stream; % imaginary part
prompt = "Would you like to add another coordinate? Y/N: ";
txt = input(prompt,"s");
while strcmpi(txt, 'Y')
    x_0 = input("Enter a x coordinate between -5 & 5: ");
    y_0 = input("Enter a y coordinate between -5 & 5: ");
    z_0 = x_0 + i*y_0;
    X = x - x_0;
    Y = y - y_0;
    r = sqrt(X.^2 + Y.^2);
    theta = atan2(Y,X);
    mu = input("Enter the doublet strength: ");
    doublet_stream = -mu./(r).*sin(theta);
    doublet_equip = -mu./(r).*cos(theta);
    phi_total = phi_total + doublet_equip; % real part
    psi_total = psi_total + doublet_stream; % imaginary part
    xpoint(end+1) = x_0;
    ypoint(end+1) = y_0;
    prompt = "Would you like to add another coordinate? Y/N: ";
    txt = input(prompt,"s");
end
end
 addMoreFlows = input("Would you like to add another potential-flow via superposition? Y/N: ","s");
end
free_stream = input("Would you like to add a free stream to your plots? Y/N: ","s");
 if strcmpi(free_stream, 'Y')
     phi_total = phi_total + real(u_flow); % real part
     psi_total = psi_total + imag(u_flow); % imaginary part
 end
    % Plot Everything
    contour(x,y,psi_total,20);
    hold on
    contour(x,y,phi_total,20);
    hold on
    plot(xpoint, ypoint, 'ro', 'MarkerFaceColor', 'r')
    grid on
    axis equal
    title('Potential-Flows')
    xlabel('Real Axis')
    ylabel('Imaginary Axis')
hold off