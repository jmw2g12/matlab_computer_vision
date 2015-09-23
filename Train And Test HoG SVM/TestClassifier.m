function [falsePosIndexList, falseNegIndexList] = TestClassifier( classifier, testset, labels )
    [Predictions,Scores]=predict(classifier,testset);
    %test_scores = svm_score(classifier,testset);
    AllTestResults=cat(2,Scores,Predictions,labels);
    truepos=0;
    trueneg=0;
    falsepos=0;
    falseneg=0;
    falsePosIndexList=[];
    falseNegIndexList=[];
    for i=1:size(testset,1)
        if (AllTestResults(i,3)==1 && AllTestResults(i,4)==1)
            truepos=truepos+1;
        elseif (AllTestResults(i,3)==0 && AllTestResults(i,4)==0)
            trueneg=trueneg+1;
        elseif (AllTestResults(i,3)==1 && AllTestResults(i,4)==0)
            falsepos=falsepos+1;
            falsePosIndexList=[falsePosIndexList; i];
        elseif (AllTestResults(i,3)==0 && AllTestResults(i,4)==1)
            falseneg=falseneg+1;
            falseNegIndexList=[falseNegIndexList; i];
        end
    end
    fprintf('\n%d\t%d\n',truepos,falsepos);
    fprintf('%d\t%d\n',falseneg,trueneg);
end

