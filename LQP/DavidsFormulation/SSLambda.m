res=vertcat(-sigma*ss_Q*ss_lambda_B1 + (ss_c1^sigma*sigma*ss_l1^(gamma + 1) - ss_c1)*ss_lambda_I + alpha_1*ss_c1 + sigma*ss_lambda_B1 + sigma*ss_lambda_W + ss_c1*ss_lambda_R, ss_c1^sigma*alpha_2*ss_c2^(-sigma + 1) - sigma*ss_Q*ss_lambda_B2 - (ss_c2^sigma*sigma*ss_l2^(gamma + 1) - ss_c2)*ss_lambda_I + sigma*ss_lambda_B2 - sigma*ss_lambda_W + ss_c2*ss_lambda_R, (gamma + 1)*ss_c1^sigma*ss_lambda_I*ss_l1^(gamma + 1) - ss_c1^sigma*alpha_1*ss_l1^(gamma + 1) - ss_l1*ss_lambda_R*ss_theta_1 + gamma*ss_lambda_W, -(gamma + 1)*ss_c2^sigma*ss_lambda_I*ss_l2^(gamma + 1) - ss_c1^sigma*alpha_2*ss_l2^(gamma + 1) - ss_l2*ss_lambda_R*ss_theta_2 - gamma*ss_lambda_W, -beta*ss_b2*ss_lambda_I + ss_Q*ss_b2*ss_lambda_I, ss_Q*ss_b2*ss_lambda_I + ss_Q*ss_lambda_B1 + ss_Q*ss_lambda_B2);