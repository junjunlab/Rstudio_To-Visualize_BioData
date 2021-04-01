#' Title meanplot
#'
#' @title This is my first R package to plot mean figures
#' @author zhang jun
#' @description Today,I create my first function,a very useful function.
#' @details You can use this function to visualize differential results from DeSeq2 software.
#'
#' @import ggplot2
#' @import ggprism
#' @import ggrepel

#' @param meanplot The plot function name
#' @param res The DeSeq2 results
#' @param log2FoldChange The log2 Fold Change value you want to choose
#' @param pvalue The p value you want to choose
#' @param baseMean The averaged gene expression
#' @param size The point size
#' @param col The point color you want to show,this is color list like c('red','blue','gray') stands for up down and no significant genes,defaults flat1
#' @param xcut The x axis range to plot,offer only one value bigger than zero.
#' @param ycut The y axis range to plot
#' @param alpha The transparency of the point
#' @param border The plot border show (true or false)
#' @param gene The gene you want to mark on the figure :is a vector
#' @param gen_size The gene name mark size on the plot
#' @param gen_stoke_col This the mark gene circular color
#' @param xdis The breaks of the x axis line
#' @param ydis The breaks of the y axis line
#' @param title The plot title contents
#' @param base_size The plot all text size
#' @param flat1 The default color
#' @param flat2 The second color
#' @param flat3 The next color
#' @param flat4 The next color
#' @param flat5 The next color
#' @param flat6 The next color
#' @param flat7 The next color
#' @param flat8 The next color
#'
#'
#' @return
#' @export

meanplot <- function(res, log2FoldChange, pvalue, baseMean,
                     size, xcut,
                     ######################################################
                     col=c('#dd2c00','#438a5e','grey'),
                     base_size=16,
                     xdis=10,ydis=5,
                     alpha= 0.8,
                     border = FALSE,
                     gene, gen_size = 6 ,
                     gen_stoke_col= "#373a40" ,
                     title="The title of this plot",
                     # 颜色素材
                     flat1 = c('#dd2c00','#438a5e','grey'),
                     flat2 = c('#e7305b','#96bb7c','grey'),
                     flat3 = c('#d54062','#519872','grey'),
                     flat4 = c('#be0000','#161d6f','grey'),
                     flat5 = c('#ff9292','#aee1e1','grey'),
                     flat6 = c('#be0000','#f58634','grey'),
                     flat7 = c('#c70039','#1a508b','grey'),
                     flat8 = c('#bb2205','#61b15a','grey'),
                     chose = list(flat1,flat2,flat3,flat4,flat5,flat6,flat7,flat8)) {
  ####################################################################
  # setting the defaults values
  if(missing(log2FoldChange)) log2FoldChange <- 1
  if(missing(pvalue)) pvalue <- 0.05
  if(missing(size)) size <- 1
  if(missing(gene)) gene <- c('')

  # setting the axis range
  if(missing(xcut)) xcut <- ceiling(max(abs(res$log2FoldChange))+2)
  # if(missing(ycut)) ycut <- ceiling(max(log2(res$baseMean)) + 2)


  #####################################################

  ####################################################################
  # assign the up-regulated and down-regulated genes
  res$threshold = factor(
    ifelse(res$pvalue < pvalue & abs(res$log2FoldChange) >= log2FoldChange,
           ifelse(res$log2FoldChange>= log2FoldChange,'Up','Down'),
           'NoSig'),levels=c('Up','Down','NoSig'))
  #####################################################################
  # add the assigned genes numbers label
  suma <- as.data.frame(table(res$threshold))
  up <- paste(suma$Var1,suma$Freq,sep = '-')[1]
  down <- paste(suma$Var1,suma$Freq,sep = '-')[2]
  nosig <- paste(suma$Var1,suma$Freq,sep = '-')[3]
  #####################################################################
  # filter the specific genes that you are interested in
  my_gene <- res[which(res$gene_name %in% gene),]
  #####################################################################

  # making plot now
  ggplot(data=res,aes(x=log2FoldChange,y=log2(baseMean))) +
    theme_prism(base_size = base_size,border = border) +
    geom_point(size = size ,
               alpha = alpha,
               aes(color=threshold)) +
    scale_color_manual(values = c('Up'=col[1],'Down'=col[2],'NoSig'=col[3]),
                       labels= c('Up'= up, 'Down'=down,'NoSig'= nosig),
                       ) +
    geom_vline(xintercept=c(-log2FoldChange,log2FoldChange),
               lty=2,col="black",size=1.3) +
    # geom_hline(yintercept = -log10(pvalue),lty=2,
    #            col="black",size=1.3) +
    theme(legend.position = c(0.9,0.9),
          legend.text = element_text(size = 16),
          legend.background = element_blank()) +
    scale_x_continuous(limits = c(-xcut,xcut),breaks = seq(-xcut,xcut,by=xdis)) +
    # scale_y_continuous(limits = c(0,ycut)) +
    geom_text_repel(data = my_gene, aes(x=log2FoldChange,y=-log10(pvalue), label = gene_name),
                    size = gen_size,
                    box.padding = unit(2, 'cm'),
                    segment.color = 'black',
                    show.legend = FALSE,
                    arrow = arrow(length = unit(0.03, "npc"),
                                  ends = "last", type = "open"),
                    fontface='italic',
                    segment.size=1 ,
                    segment.alpha= 0.8) +
    geom_point(size=4,colour=gen_stoke_col, shape=1,stroke=2,
               data = my_gene, aes(x=log2FoldChange,y=-log10(pvalue))) +
    labs(title = title) +
    coord_flip()

}
