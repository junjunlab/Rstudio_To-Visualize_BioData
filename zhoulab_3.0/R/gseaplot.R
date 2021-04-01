#' Title
#'
#' @param res The gsea software results
#' @param psize Point size
#' @param lsize Line size
#' @param base_size Theme base size
#' @param border Plot border
#' @param title Plot title
#' @param lcol Line color
#' @param segcol Segment color
#' @param xdis x axis distance
#'
#' @return
#' @export
#'
#' @examples
gseaplot1 <- function(res,
                     psize=1,
                     lsize=2.5,
                     base_size=16,
                     border=TRUE,
                     title= 'Test Plot',
                     lcol='red',
                     segcol='black',
                     xdis=10000){
  print("Welcome to use zhoulab gseaplot function ,hope you have a good experience!")
  ggplot(data = res,aes(x=RANK.IN.GENE.LIST,
                        y=RUNNING.ES)) +
    geom_point(size=psize) + #添加点
    geom_line(size=lsize,color=lcol) + #将点连成线
    geom_segment(aes(xend=RANK.IN.GENE.LIST,yend=0),color=segcol) + #添加竖线
    theme_classic() +
    ylab('Enrichment score (ES)') +
    xlab('Gene ranked positions') +
    theme_prism(base_size = base_size,border = border) +
    geom_hline(yintercept = 0,size=1) +
    labs(title = paste('GSEA Enrichment plot:',title,sep = '')) +
    scale_x_continuous(breaks = seq(0,max(res$RANK.IN.GENE.LIST)+10000,by=xdis))
}

################################################################################
gseaplot2 <- function(res,
                      psize=4,
                      lsize=1.5,
                      base_size=16,
                      border=TRUE,
                      title= 'Test Plot',
                      xdis=10000,
                      col=rev(rainbow(6))){
  print("Welcome to use zhoulab gseaplot function ,hope you have a good experience!")
  ggplot(data = res,aes(x=RANK.IN.GENE.LIST,
                        y=RUNNING.ES,
                        color=RANK.METRIC.SCORE)) +
    geom_point(size=psize) + #添加点
    geom_line(size=lsize) + #将点连成线
    geom_segment(aes(xend=RANK.IN.GENE.LIST,yend=0)) + #添加竖线
    scale_color_gradientn(colours=col) +
    theme_classic() +
    ylab('Enrichment score (ES)') +
    xlab('Gene ranked positions') +
    theme_prism(base_size = base_size,border = border) +
    geom_hline(yintercept = 0,size=1) +
    labs(title = paste('GSEA Enrichment plot:',title,sep = '')) +
    scale_x_continuous(breaks = seq(0,max(res$RANK.IN.GENE.LIST)+10000,by=xdis))

}
