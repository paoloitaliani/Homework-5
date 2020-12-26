# Exercise 1

On the Virtuale page of the course you find the dataset stars5000.dat.
You can read it using
stars5000 <- read.table("stars5000.dat",header=TRUE)
The data contain information about 5000 celestial objects (most of these are stars,
but objects also include quasars, distant galaxies, and a certain amount of optical
noise) of which spectra were obtained by mounting a prism in front of a telescope.
The aim is to find classes of celestial objects with specific characteristics. There are
six variables containing summary information of the spectra (original spectra contain 300 highly dependent variables; the original database contains about 4 million
objects). These are
casn Signal-to-noise ratio of the Calcium break (which is a characteristic discontinuity in spectra of galaxies)
cacont Contrast of the Calcium break to smoothed version of the spectrum
kl1 First principal component of smoothed spectrum
kl2 Second principal component of smoothed spectrum
xh1 “Half power point” in upper spectrum
xh2 “Half power point” in lower spectrum (these are indicators of where trhe spectral density is concentrated)
Obviously you are not expected to understand the meaning of these in any detail.
What is interesting regarding applied statistics is that the astronomers, with some
help from statisticians, used a judicious mix of subject-matter knowledge (knowing
what kind of information in the spectra is important) and statistical techniques
(such as principal component analysis and kernel density smoothing) in order to
reduce the highly redundant and noisy high dimensional information in the original
spectra. Such an approach is often better than relying on the data (or the scientists’
knowledge) alone.
Cluster these data using Gaussian mixtures, t-mixtures, skew-normal mixtures, and
skew-t mixtures, and decide which clustering you find most convincing, with reasons.
Although methods with flexible covariance/shape matrices can in principle handle
variables with very different variances, value ranges here are vastly different, and
standardisation may help, maybe in a robust manner (using median and MAD)
because of the presence of outliers. If you have time, you can compare how much of
a difference that makes.

# Exercise 2

The flexmixedruns function used to fit the latent class categorical mixture on the course slides is in package fpc. There is another R-function to fit that
model, namely poLCA in package poLCA. I’d have expected the poLCA function to be
as good as flexmixedruns or better (because I wrote the flexmixedruns function
myself and did it pretty quickly), however the poLCA function couldn’t handle the
Veronica example because there were probably too many variables.
The package poLCA has an example dataset for latent class clustering with categorical variables that are not just binary called “election”, to be loaded by data(election)
(requiring library(poLCA)); also look up the election help page for some documentation about this data.
The categorical variables to be clustered are variables 1-12 (to be extracted before
clustering; this can be done by election12 <- election[,1:12]).
The dataset has missing values. There are two different ways of handling them in
the latent class analysis. The first one is to only use the 1311 observations (out of
1785) that do not have missing values. You can extract them like this:
electioncomplete <- election12[complete.cases(election12),]
The second way is to define a new category for the missing values, i.e., replacing
all missing values NA by a category called “NA”. Note that all the variables are of
type “factor”, and this requires to define a new factor level:
electionwithna <- election12
for (i in 1:12){
levels(electionwithna[,i]) <- c(levels(election12[,i]),"NA")
electionwithna[is.na(election12[,i]),i] <- "NA"
}
Run the following clusterings and compare them using MDS plots based on the
simple matching distance. Use two different MDS outputs, one for clusterings computed on electioncomplete and one for clusterings computed on electionwithna.
Also compute ARIs for every pair of clustering. Where you compare one clustering
based on electioncomplete with 1311 observations and one clustering based on
electionwithna with 1785 observations, only use the 1311 observations without
missing values for the ARI computation. Here is an example how you can extract
these:
clustering_to_compare <- clustering_with_na[complete.cases(election12)]
(a) Compute a latent class clustering with 3 clusters using poLCA as shown on
the help page of election (model nes3). This will automatically only use
complete cases, so running it as on the help page is equivalent to running it on
electioncomplete.
(b) Compute a latent class clustering with 3 clusters using poLCA on the electionwithna
data.
(c) Compute a latent class clustering with 3 clusters using flexmxedruns on the
electioncomplete data.
(d) Compute a latent class clustering with 3 clusters using flexmixedruns on the
electionwithna data.
(e) Compute a distance-based clustering of your choice with 3 clusters based on
the simple matching distance on the electioncomplete data.
(f) Compute the same distance-based clustering with 3 clusters on the electionwithna
data.
(g) Either on electioncomplete or on electionwithna (your choice), compute a
latent class clustering using flexmxedruns with estimated number of clusters.
Remark: Using the simple matching distance there is a third way of handling
missing values, which is to average the distance for every pair of observations only
over those variables with both observations non-missing, i.e., the way missing values
are handled in the Gower coefficient. This is just for information; you are not asked
to use this here, although it is in general, when running a distance-based clustering,
preferable to complete cases only analysis.
