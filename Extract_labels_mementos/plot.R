  library(readr)
  library(ggplot2)
  library(scales)
  library(lubridate)

  df <- read_delim("oldUImementos_all_logical_wtweetedat.tsv", 
                        "\t", escape_double = FALSE, col_names = FALSE, 
                        col_types = cols(X1 = col_datetime(format = "%Y%m%d%H%M%S"), 
                                         X2 = col_character()), trim_ws = TRUE)
  
  #X2 = col_logical()
  colnames(df) <- c("DateTime", "Label","ID")
  attach(df)
  status_levels <- c("FALSE", "TRUE", "Tweeted_at")
  status_colors <- c("#4169E1", "#00B050", "#DC143C")
  
  Label <- factor(Label, levels=status_levels, ordered=TRUE)
  
  
  month_date_range <- seq(from = as.Date("2020-05-01"), to = as.Date("2020-12-01"), by='month')
  month_format <- format(month_date_range, '%b')
  month_df <- data.frame(month_date_range, month_format)
  df$DateTime<- as.Date(df$DateTime)
  
  
  timeline_plot<-ggplot(df,aes(x=DateTime, y=ID, col=Label))+
    scale_color_manual(values=status_colors, labels=status_levels, drop = FALSE)+
    theme_classic()+
    geom_hline(yintercept=ID, color = "black", size=0.3)+
    geom_point(aes(y=ID), size=2)+
    ylab("Tweet")+
    xlab("Date")+
    scale_x_date(date_labels = "%b", breaks = breaks_pretty(7), limits = c(min(month_df$month_date_range), max=max(month_df$month_date_range)))+
    scale_y_continuous(breaks = breaks_pretty(7), limits = c(1,7))
  
  #which(df$DateTime=="2020-09-09")
  #df$DateTime[992]
  #as.numeric(df$DateTime[992])
  
  timeline_plot<-timeline_plot+
    theme(axis.line.y=element_blank(),axis.ticks.y=element_blank(), legend.position = "top")+
    labs(colour="")+
    scale_color_manual(labels = c("Memento with label", "Memento without label","Tweeted at"), values = c("#4169E1", "#00B050", "#DC143C"))+
    geom_vline(xintercept=as.numeric(df$DateTime[c(992, 1060)]), linetype="dotted")
  
  timeline_plot

