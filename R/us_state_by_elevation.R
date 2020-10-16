library(tidyverse, help, pos = 2, lib.loc = NULL)
library(plotly)
dfraw <- read_csv('C:/Users/PSYC-wl8856/Desktop/Github/veritas1uxmea.github.io/data/us_states_by_elevation.csv')

colnames(dfraw)
head(dfraw)

df <- dfraw %>% 
  rename(State = `Statefederal district or territory`) %>% 
  filter(State != "United States") %>%  # get rid of redundant info
  mutate(`Highest point` = gsub('\\[.*' , '', `Highest point`), # delete citation label from wiki
         `Lowest point` = gsub('\\[.*' , '', `Lowest point`),
         `Highest elevation` = as.numeric(str_sub(gsub('\\m.*', '', `Highest elevation`),1,-2)),
         `Lowest elevation` = as.numeric(str_sub(gsub('\\m.*', '', gsub('.*ft', '', `Lowest elevation`)),1,-2))) %>% 
  mutate(`Lowest elevation` = ifelse(is.na(`Lowest elevation`),0,`Lowest elevation`)) %>%  #replace NA value 
  arrange(desc(`Highest elevation`)) %>% 
  mutate(id = seq_along(State)) %>% 
  mutate(State = fct_reorder(State,desc(`Highest elevation`))) %>% 
  mutate(`Elevation span` = `Highest elevation` - `Lowest elevation`)


df %>% 
  rename(`Highest elevation (m)` = `Highest elevation`,
         `Lowest elevation (m)` = `Lowest elevation`,
         `Elevation span (m)` = `Elevation span`) %>% 
  ggplot()+
  geom_bar(aes(x = State,
               y = `Highest elevation (m)`,
               fill = `Elevation span (m)`),
           stat = 'identity',
           color = NA)+
  geom_bar(aes(x = State,
               y = `Lowest elevation (m)`),
               stat = 'identity', 
           fill = 'white', 
           color = 'white')+
  geom_hline(yintercept = 0, 
             color = 'dodgerblue', 
             size = 1.5)+
  labs(x = '',
       y = 'Elevation (m)',
       fill = 'Elevation \nspan (m)')+
  theme_minimal()+
  scale_fill_viridis(option = 'D')+
  theme(axis.text.x = element_text(angle = 90,size = rel(1.5)),
        axis.text.y = element_text(size = rel(1.2)),
        axis.title.y = element_text(size = rel(1.4)),
        panel.grid.major.x = element_blank()) -> p
p

ggplotly(p)



# 
# df %>% 
#   ggplot(aes(x =State,
#              ymin = `Lowest elevation`,
#              ymax = `Highest elevation`,
#              fill = `Elevation span`))+
#   geom_ribbon()+
#   geom_hline(yintercept = 0, color = 'dodgerblue', size = 1.5)+
#   # geom_text(aes(y=`Highest elevation`, label = `Highest elevation`))+
#   labs(x = '',
#        y = 'Elevation (m)',
#        fill = 'Elevation \nspan (m)')+
#   theme_minimal()+
#   scale_fill_viridis()+
#   theme(axis.text.x = element_text(angle = 90,size = rel(1.5))) -> p
# 
# p
# ggplotly(p)
# plotly_json(p)
# 
# 
# df %>% 
#   gather(HighLow,value,`Highest elevation`,`Lowest elevation`) %>% 
#   select(State,HighLow, value) %>% 
#   ggplot(aes(x = State, y = value))+
#   geom_bar(aes( fill = HighLow), stat='identity') -> p
# 
# 
# ggplotly(p)
# 
# 
# 
# 
# 
# df %>% 
#   ggplot(aes(x = State,
#              xmin = id, xmax = id + 0.9,
#              ymin = `Lowest elevation`,
#              ymax = `Highest elevation`,
#              fill = `Elevation span`))+
#   geom_rect(color = NA)+
#   geom_hline(yintercept = 0, color = 'dodgerblue', size = 1.5)+
#   geom_text(aes(y=`Highest elevation`, label = `Highest elevation`),color=NA)+
#   labs(x = '',
#        y = 'Elevation (m)',
#        fill = 'Elevation \nspan (m)')+
#   theme_minimal()+
#   scale_fill_viridis()+
#   theme(axis.text.x = element_text(angle = 90,size = rel(1.5))) -> p
# 
# p
# ggplotly(p)
# plotly_json(p)
# 

# =========================================================







