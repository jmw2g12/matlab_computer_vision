function [] = SVMtoYAML( classifier, filename )

beta = transpose(classifier.Beta);
beta_string = mat2str(beta);
beta_list = strrep(beta_string,' ',',');
beta_yaml_line = sprintf('''svm_beta'': %s',beta_list);

scale = classifier.KernelParameters.Scale;
scale_yaml_line = sprintf('''svm_scale'': %d',scale);

bias = classifier.Bias;
bias_yaml_line = sprintf('''svm_bias'': %d',bias);

yaml_file = sprintf('{\n%s,\n%s,\n%s\n}',beta_yaml_line,scale_yaml_line,bias_yaml_line);

filename = strcat(filename,'.yaml');
fid=fopen(filename,'w');
fprintf(fid,yaml_file);
fclose(fid);

disp(yaml_file);
end

