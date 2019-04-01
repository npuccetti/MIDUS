midus <- read.csv("//datastore01.psy.miami.edu/Users/NPuccetti/Grad School/MANATEE/MIDUS/2019 Analysis/datafiles/fulldata_32919_V5.csv")

midus <- read.csv("/Volumes/Users/NPuccetti/Grad School/MANATEE/MIDUS/2019 Analysis/datafiles/fulldata_32919_V5.csv")
#midus <- read.csv("//datastore01.psy.miami.edu/Users/NPuccetti/Grad School/MANATEE/MIDUS/2019 Analysis/datafiles/fulldata_22119_V3.csv")
#midus <- read.csv("/Volumes/Users/NPuccetti/Grad School/MANATEE/MIDUS/2019 Analysis/datafiles/fulldata_22119_V3.csv")
#midus <- read.csv("//datastore01.psy.miami.edu/Users/NPuccetti/Grad School/MANATEE/MIDUS/Data_MIDUSinfo/fulldata1.csv")

midus$diary_days
hist(midus$na_mean)
midus$na_mean_trsf <- sqrt(midus$na_mean)
hist(midus$na_mean_trsf)



mod1 <- lm(midus$na_mean ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg)
summary(mod1)

#mod1.25 <- lm(midus$na_mean_trsf ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg)
#summary(mod1.25)

mod1.5 <- lm(midus$na_mean ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod1.5)

mod1.75 <- lm(midus$na_mean_trsf ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod1.75)

library('ggplot2')
#ggplot(EMA_long_reduc, aes(x = resp_index, y = PTQ, group = subid, colour = subid)) +
  geom_path(alpha=0.5, size = .8) +
  stat_summary(aes(y = PTQ, group = 1), geom = "line", size = 1, fun.y = mean) +
  theme_gray()
  
# read dataset
df = midus

mod1.5$fitted.values
df$fitted <- mod1.5$fitted.values

# create multiple linear model
# lm_fit <- lm(mpg ~ cyl + hp, data=df)
lm_fit <- lm(na_mean_trsf ~ neg_f3.neg_nf_Lamyg + neu_f3.neu_nf_Lamyg + diary_days + age + gender, data=df)
summary(lm_fit)

# save predictions of the model in the new data frame 
# together with variable you want to plot against
#predicted_df <- data.frame(mpg_pred = predict(lm_fit, df), hp=df$hp)
predicted_df <- data.frame(namean_pred = predict(lm_fit, df), dissim=df$neg_f3.neg_nf_Lamyg)

# this is the predicted line of multiple linear regression
#ggplot(data = df, aes(x = mpg, y = hp)) + 
#  geom_point(color='blue') +
#  geom_line(color='red',data = predicted_df, aes(x=mpg_pred, y=hp))
ggplot(data = df, aes(x = neg_f3.neg_nf_Lamyg, y = na_mean_trsf)) + 
  geom_point(color='blue') +
  geom_smooth(color='red', method = "lm", data = predicted_df, aes(x=dissim, y=namean_pred))



mod2 <- lm(midus$pa_mean ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg)
summary(mod2)

mod2.5 <- lm(midus$pa_mean ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod2.5)

mod3 <- lm(midus$sr_na_slope ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg)
summary(mod3)

mod3.5 <- lm(midus$sr_na_slope ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod3.5)

hist(midus$neg_f3.neg_nf_Lamyg)
hist(midus$na_mean)
hist(sqrt(midus$na_mean))
midus$na_mean_trsf <- sqrt(midus$na_mean)



mod4 <- lm(midus$M2.NA.SCORE_f.autocorrelation.lag1.value ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod4)

mod4.5 <- lm(midus$M2.NA.SCORE_f.autocorrelation.lag1.value ~ midus$na_mean + midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod4.5)










############

#mediation

summary(lm(pwb_composite ~ na_mean + diary_days + age + gender, data = midus))

     
mod1.75 <- lm(midus$na_mean_trsf ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod1.75)

# model <- ' # direct effect
#              OC4_loglambda31_100 ~ c*PHQ9 
#            # mediator 
#              RRS2 ~ a*PHQ9
#              OC4_loglambda31_100 ~ b*RRS2
#            # indirect effect (a*b)
#              ab := a*b
#            # total effect
#              total := c + (a*b) 

library('lavaan')

model <- ' # direct effect
             pwb_composite ~ c*neg_f3.neg_nf_Lamyg + d*neu_f3.neu_nf_Lamyg + e*diary_days + f*age + g*gender 
           # mediator 
             na_mean_trsf ~ a*neg_f3.neg_nf_Lamyg + h*neu_f3.neu_nf_Lamyg + i*diary_days + j*age + k*gender 
             pwb_composite ~ b*na_mean_trsf
           # indirect effect (a*b)
             ab := a*b
           # total effect
             total := c + (a*b) '
fitsem <- sem(model,data = midus, bootstrap = 10000)
summary(fitsem, fit.measures=TRUE, rsquare=TRUE)

boot.fit <- parameterEstimates(fitsem, boot.ci.type="bca.simple",level=0.95, ci=TRUE,standardized = FALSE)
boot.fit


