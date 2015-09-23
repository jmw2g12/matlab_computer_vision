function [SVMClassifier, TotalTestingSet] = TrainAndTestHOGSVM( PosDir, NegDir )
    
    PosFiles=[];
    NegFiles=[];
    PosHogFeatures=[];
    NegHogFeatures=[];
    falsePosIndexList=[];
    falseNegIndexList=[];

    % Gets list of files in each directory. 'name' field holds filename.
    PosFiles=dir(strcat(PosDir,'/*.png'));
    NegFiles=dir(strcat(NegDir,'/*.png'));

    % For each file in the list created above, extract hog features.
    % Stores positive and negative features separately.
    for i=1:size(PosFiles,1)
        % Attaches names to the start of the features so as to identify them
        PosHogFeatures(i,:)=extractHOGFeatures(imread(strcat(PosDir,'/',PosFiles(i).name)),'CellSize',[32 32]);
    end
    for i=1:size(NegFiles,1)
        % Attaches names to the start of the features so as to identify them
        NegHogFeatures(i,:)=extractHOGFeatures(imread(strcat(NegDir,'/',NegFiles(i).name)),'CellSize',[32 32]);
    end
    
%     % This will be used to shuffle each list of features 
%     PosListShuffler=transpose(randperm(size(PosHogFeatures,1)));
%     PosHogFeatures=PosHogFeatures(PosListShuffler,:);
%     PosFiles=PosFiles(PosListShuffler,:);
%     NegListShuffler=transpose(randperm(size(NegHogFeatures,1)));
%     NegHogFeatures=NegHogFeatures(NegListShuffler,:);
%     NegFiles=NegFiles(NegListShuffler,:);
    
    % Separates list of features into a training set and a testing set
    PosTrainingSet=PosHogFeatures(1:ceil(size(PosHogFeatures,1)./2),:);
    PosTestingSet=PosHogFeatures(ceil(size(PosHogFeatures,1)./2)+1:size(PosHogFeatures,1),:);
    NegTrainingSet=NegHogFeatures(1:ceil(size(NegHogFeatures,1)./2),:);
    NegTestingSet=NegHogFeatures(ceil(size(NegHogFeatures,1)./2)+1:size(NegHogFeatures,1),:);
    
    % Concatenates training and testing sets.
    TotalTrainingSet=cat(1,PosTrainingSet,NegTrainingSet);
    TotalTestingSet=cat(1,PosTestingSet,NegTestingSet);
    
    % Makes the label set for training.
    TrainingLabels=repmat(1,size(PosTrainingSet,1),1);
    TrainingLabels=cat(1,TrainingLabels,repmat(0,size(NegTrainingSet,1),1));
    
    % Makes the label set for testing.
    TestingLabels=repmat(1,size(PosTestingSet,1),1);
    TestingLabels=cat(1,TestingLabels,repmat(0,size(NegTestingSet,1),1));
    
    % Create svm classifier
    SVMClassifier=fitcsvm(TotalTrainingSet,TrainingLabels);
    
    % Run the classifier test using separate test set. Returns index values
    % of the wrongly classified images.
    [falsePosIndexList,falseNegIndexList]=TestClassifier(SVMClassifier,TotalTestingSet,TestingLabels);
    
    if (numel(falsePosIndexList)>0) fprintf('\nfalse positives:\n'); end
    for i=1:numel(falsePosIndexList)
        %disp(NegFiles(falsePosIndexList(i)).name);
    end
    if (numel(falseNegIndexList)>0) fprintf('\nfalse negatives:\n'); end
    for i=1:numel(falseNegIndexList)
        %disp(PosFiles(falseNegIndexList(i)).name);
    end
end

