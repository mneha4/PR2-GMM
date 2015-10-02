load('4_class_overlapping_data/Class1.txt');
load('4_class_overlapping_data/Class2.txt');
Class1 = [Class1; Class2];
hold on
plot(Class1(:,1), Class1(:,2), '.')
[means, covs, coeffs, final] = pr_kmeans(Class1,6); 
means
final
plot(means(:,1), means(:,2), 'r+', 'MarkerSize', 20, 'LineWidth',5)
[idx, means] = kmeans(Class1,6,'Display','final');
means
plot(means(:,1), means(:,2), 'gx', 'MarkerSize', 20, 'LineWidth',5)
