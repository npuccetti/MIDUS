
midus <- read.csv("//datastore01.psy.miami.edu/Users/NPuccetti/Grad School/MANATEE/MIDUS/2019 Analysis/datafiles/fulldata_22119_V3.csv")
midus <- read.csv("/Volumes/Users/NPuccetti/Grad School/MANATEE/MIDUS/2019 Analysis/datafiles/fulldata_22119_V3.csv")
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
p <-  ggplot(data = df, aes(x = neg_f3.neg_nf_Lamyg, y = na_mean_trsf)) + 
  geom_point(color='darkslategray3',size = 3.5) +
  geom_smooth(color='darkslategray4',size = 2.5, method = "lm", data = predicted_df, aes(x=dissim, y=namean_pred)) +
  #xlab("Dissimiliarity") + # for the x axis label
  #ylab("Negative Affect") + # for the y axis label
  theme_gray()
 p + theme(axis.title.x=element_blank(),
           axis.title.y=element_blank(),
           axis.text.y=element_text(size = 18),
           axis.text.x=element_text(size = 18))

dv_cov <- lm(midus$na_mean_trsf ~ midus$diary_days + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(dv_cov)

iv_cov <- lm(midus$neg_f3.neg_nf_Lamyg ~ midus$diary_days + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(iv_cov)

plot(iv_cov$residuals, dv_cov$residuals)




mod2 <- lm(midus$pa_mean ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg)
summary(mod2)

mod2.5 <- lm(midus$pa_mean ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod2.5)


lm_fit1 <- lm(pa_mean ~ neg_f3.neg_nf_Lamyg + neu_f3.neu_nf_Lamyg + diary_days + age + gender, data=df)
summary(lm_fit1)

# save predictions of the model in the new data frame 
# together with variable you want to plot against
#predicted_df <- data.frame(mpg_pred = predict(lm_fit, df), hp=df$hp)
predicted_df <- data.frame(pamean_pred = predict(lm_fit1, df), dissim=df$neg_f3.neg_nf_Lamyg)

# this is the predicted line of multiple linear regression
#ggplot(data = df, aes(x = mpg, y = hp)) + 
#  geom_point(color='blue') +
#  geom_line(color='red',data = predicted_df, aes(x=mpg_pred, y=hp))
p <-  ggplot(data = df, aes(x = neg_f3.neg_nf_Lamyg, y = pa_mean)) + 
  geom_point(color='pink3',size = 3.5) +
  geom_smooth(color='pink4',size = 2.5, method = "lm", data = predicted_df, aes(x=dissim, y=pamean_pred)) +
  #xlab("Dissimiliarity") + # for the x axis label
  #ylab("Negative Affect") + # for the y axis label
  theme_gray()
p + theme(axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_text(size = 18),
          axis.text.x=element_text(size = 18))

mod3 <- lm(midus$sr_na_slope ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg)
summary(mod3)

mod3.5 <- lm(midus$sr_na_slope ~ midus$diary_days + midus$neg_f3.neg_nf_Lamyg + midus$neu_f3.neu_nf_Lamyg + midus$age + midus$gender)
summary(mod3.5)


lm_fit1 <- lm(sr_na_slope ~ neg_f3.neg_nf_Lamyg + neu_f3.neu_nf_Lamyg + diary_days + age + gender, data=df)
summary(lm_fit1)

# save predictions of the model in the new data frame 
# together with variable you want to plot against
#predicted_df <- data.frame(mpg_pred = predict(lm_fit, df), hp=df$hp)
predicted_df <- data.frame(naslope_pred = predict(lm_fit1, df), dissim=df$neg_f3.neg_nf_Lamyg)

# this is the predicted line of multiple linear regression
#ggplot(data = df, aes(x = mpg, y = hp)) + 
#  geom_point(color='blue') +
#  geom_line(color='red',data = predicted_df, aes(x=mpg_pred, y=hp))
p <-  ggplot(data = df, aes(x = neg_f3.neg_nf_Lamyg, y = sr_na_slope)) + 
  geom_point(color='darkseagreen3',size = 3.5) +
  geom_smooth(color='darkseagreen4',size = 2.5, method = "lm", data = predicted_df, aes(x=dissim, y=naslope_pred)) +
  #xlab("Dissimiliarity") + # for the x axis label
  #ylab("Negative Affect") + # for the y axis label
  theme_gray()
p + theme(axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_text(size = 18),
          axis.text.x=element_text(size = 18))

hist(midus$neg_f3.neg_nf_Lamyg)
hist(midus$na_mean)
hist(sqrt(midus$na_mean))
midus$na_mean_trsf <- sqrt(midus$na_mean)

p <-  ggplot(data = df, aes(x = na_mean)) +
  geom_histogram(fill='darkseagreen')
p
