res=vertcat(-((-ss_tau + 1)^(1/gamma)*ss_theta_1*ss_c1^(-sigma/gamma)*ss_theta_1^(1/gamma) + (-ss_tau + 1)^(1/gamma)*ss_theta_2*ss_c2^(-sigma/gamma)*ss_theta_2^(1/gamma))*ss_tau + ss_Q*ss_b2 + 2*ss_T - ss_b2 + ss_g, -(-ss_tau + 1)^(1/gamma)*ss_theta_1*ss_c1^(-sigma/gamma)*ss_theta_1^(1/gamma) - (-ss_tau + 1)^(1/gamma)*ss_theta_2*ss_c2^(-sigma/gamma)*ss_theta_2^(1/gamma) + ss_c1 + ss_c2 + ss_g, -((-ss_tau + 1)^(1/gamma)*ss_c2^(-sigma/gamma)*ss_theta_2^(1/gamma))^(gamma + 1)*ss_c2^sigma - ss_T + ss_c2);