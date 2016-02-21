library(ggplot2) #plotting
library(scales) #for displaying mathmatical symbol

e=320
break.x=.0125 

data.pi= c()
for (i in 1:e){ 
  size=10^(4+break.x*i)
  x=runif(size,min=-.5,max=.5)
  y=runif(size,min=-.5,max=.5)
  data=data.frame(x=x,
                  y=y,
                  r=sqrt(x^2+y^2)
                  )
  data.pi[i]=(sum(data$r<=0.5)/size)*4
}

#Graphing
plot=data.frame(epi=data.pi, 
                exp=10^(4+break.x*(1:e))
                )
g=ggplot(plot, aes(x=exp, y=epi))+
  geom_line(alpha=.8,colour="blue")+
  geom_point(alpha=.65, size=rel(2))+
  geom_hline(yintercept=pi,colour="red")+ 
  scale_y_continuous(breaks= c(round(pi,4),setdiff(seq(3.1,3.2,by=.002),c(3.142))))+
  scale_x_log10     (labels= trans_format("log10", math_format(10^.x)),
                     breaks= trans_breaks("log10", function(x) 10^x))+
  theme(axis.title.x= element_text(size=rel(2)),
        axis.text.x= element_text(size=rel(2.5)),
        axis.title.y= element_text(size=rel(2)),
        axis.text.y= element_text(size=rel(2))
        )+
  labs(x = "Exponent of 10", y ="Estimated pi")
g
ggsave("pi.png",g, scale=2, width=16, height=9)
getwd()
