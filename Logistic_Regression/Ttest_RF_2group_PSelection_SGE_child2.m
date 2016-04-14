function Accuracy = Ttest_RF_2group_PSelection_SGE_child2(ResultantFolder, Subjects_Label)

for i = 1:length(Subjects_Label)
    tmp = load([ResultantFolder filesep 'predicted_labels_' num2str(i) '.mat']);
    predicted_labels(i) = tmp.predicted_label;
%     tmp = load([ResultantFolder filesep 'decision_values_' num2str(i) '.mat']);
%     decision_values(i) = tmp.decision_value;
    tmp = load([ResultantFolder filesep 'RetainID_' num2str(i) '.mat']);
    RetainID_save{i} = tmp.RetainID;
%     tmp = load([ResultantFolder filesep 'w_' num2str(i) '.mat']);
%     w{i} = tmp.w;
end

predicted_labels(find(predicted_labels == 0)) = -1;
Subjects_Quantity = length(Subjects_Label);

Group1_Index = find(Subjects_Label == 1);
Group0_Index = find(Subjects_Label == -1);
Category_group1 = predicted_labels(Group1_Index);
% Y_group1 = decision_values(Group1_Index);
Category_group0 = predicted_labels(Group0_Index);
% Y_group0 = decision_values(Group0_Index);

% save([ResultantFolder filesep 'Y.mat'], 'Y_group1', 'Y_group0');
save([ResultantFolder filesep 'Category.mat'], 'Category_group1', 'Category_group0');

group0_Wrong_ID = find(Category_group0 == 1);
group0_Wrong_Quantity = length(group0_Wrong_ID);
group1_Wrong_ID = find(Category_group1 == -1);
group1_Wrong_Quantity = length(group1_Wrong_ID);
disp(['group0: ' num2str(group0_Wrong_Quantity) ' subjects are wrong ' mat2str(group0_Wrong_ID) ]);
disp(['group1: ' num2str(group1_Wrong_Quantity) ' subjects are wrong ' mat2str(group1_Wrong_ID) ]);
save([ResultantFolder filesep 'WrongInfo.mat'], 'group0_Wrong_Quantity', 'group0_Wrong_ID', 'group1_Wrong_Quantity', 'group1_Wrong_ID');
Accuracy = (Subjects_Quantity - group0_Wrong_Quantity - group1_Wrong_Quantity) / Subjects_Quantity;
disp(['Accuracy is ' num2str(Accuracy) ' !']);
save([ResultantFolder filesep 'Accuracy.mat'], 'Accuracy');
group0_Quantity = length(find(Subjects_Label == -1));
group1_Quantity = length(find(Subjects_Label == 1));
Sensitivity = (group0_Quantity - group0_Wrong_Quantity) / group0_Quantity;
disp(['Sensitivity is ' num2str(Sensitivity) ' !']);
save([ResultantFolder filesep 'Sensitivity.mat'], 'Sensitivity');
Specificity = (group1_Quantity - group1_Wrong_Quantity) / group1_Quantity;
disp(['Specificity is ' num2str(Specificity) ' !']);
save([ResultantFolder filesep 'Specificity.mat'], 'Specificity');
PPV = length(find(Category_group0 == -1)) / length(find([Category_group0 Category_group1] == -1));
disp(['PPV is ' num2str(PPV) ' !']);
save([ResultantFolder filesep 'PPV.mat'], 'PPV');
NPV = length(find(Category_group1 == 1)) / length(find([Category_group0 Category_group1] == 1));
disp(['NPV is ' num2str(NPV) ' !']);
save([ResultantFolder filesep 'NPV.mat'], 'NPV');

% % Calculating weight
% RetainID_all = [];
% w_all = [];
% for i = 1:length(RetainID_save)
%     RetainID_all = [RetainID_all RetainID_save{i}];
%     w_all = [w_all w{i}];
% end
% Feature_selected_unique = unique(RetainID_all);
% for i = 1:length(Feature_selected_unique)
%     index = find(RetainID_all == Feature_selected_unique(i));
%     Feature_selected(i).ID = Feature_selected_unique(i);
%     Feature_selected(i).frequency = length(index);
%     Feature_selected(i).averageW = mean(abs(w_all(index)));
% end
% save([ResultantFolder filesep 'Feature_selected.mat'], 'Feature_selected');
% 
% ID_All = [Feature_selected.ID];
% Frequency_All = [Feature_selected.frequency];
% Weight_All = [Feature_selected.averageW];
% 
% % Select features which with frequency bigger than 55 (SubjectQuantity*9/10)
% Index = find(Frequency_All >= round(Subjects_Quantity*9/10));
% ID_All_2 = ID_All(Index);
% Frequency_All_2 = Frequency_All(Index);
% Weight_All_2 = Weight_All(Index);
% 
% [sort_weight, sort_ind] = sort(abs(Weight_All_2), 2);
% ID_All_3 = ID_All_2(sort_ind);
% Weight_All_3 = sort_weight;
% 
% % Select first 20 features with biggest weight
% for i = 1:20
%     ID_Final(i) = ID_All_3(end - i + 1);
%     Weight_Final(i) = Weight_All_3(end - i + 1);
% end
% save([ResultantFolder filesep 'ID_Final.mat'], 'ID_Final');
% save([ResultantFolder filesep 'Weight_Final.mat'], 'Weight_Final');
% 
