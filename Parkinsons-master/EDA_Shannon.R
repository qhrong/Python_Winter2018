##EDA from Shannon
Did extreme indifference cause Parkinson’s patients to have lower response rate?
  ```{r}
#Our data is relatively small, so I think maybe scatter plots are sufficient? Do you have any other appropriate plot types? 
library(dplyr)
library(ggplot2)

#Plot Apathy_scale vs Response
merge_c_t %>% group_by(PD) %>% ggplot(aes(x=Apathy_scale,y=response))+geom_point()+facet_wrap(~PD)+coord_flip()

#Plot LARS_total vs Response
merge_c_t %>% group_by(PD) %>% ggplot(aes(x=LARS_total,y=response))+geom_point()+facet_wrap(~PD)+coord_flip()

#Plot LARS subgroups vs Response
merge_c_t$PD <- as.character(merge_c_t$PD)
library(gridExtra)
p1 <- ggplot(merge_c_t,aes(x=LARS_AI,y=response,color=PD))+geom_point()
p2 <- ggplot(merge_c_t,aes(x=LARS_IntelCurio,y=response,color=PD))+geom_point() 
p3 <- ggplot(merge_c_t,aes(x=LARS_Emotion,y=response,color=PD))+geom_point() 
p4 <- ggplot(merge_c_t,aes(x=LARS_SelfAware,y=response,color=PD))+geom_point() 
grid.arrange(p1,p2,p3,p4,nrow=2)

#Plot Apathy vs UPDRS(Severity of disorder)
ggplot(merge_c_t,aes(x=Apathy_scale,y=UPDRS,color=PD))+geom_point() #the result is wierd because a lot of NA are removed.
cor.test(data = merge_c_t, ~UPDRS + Apathy_scale) #0.19 

#Plot Apathy vs Depression
ggplot(merge_c_t,aes(x=GDS,y=Apathy_scale,color=PD))+geom_point()
#Calculate correlation btw Apathy and Depression
cor.test(data = merge_c_t, ~ GDS + Apathy_scale) #0.43
```

