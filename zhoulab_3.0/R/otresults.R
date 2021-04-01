#' Title This script can output significant up and down genes and up genes and down genes
#'
#' @param res Your all diff data
#' @param log2FoldChange The range you want to filter
#' @param pvalue The range you want to filter
#' @param name The output file name
#'
#'
#' @return
#' @export
#'

otresults <- function(res,
                      log2FoldChange=1,
                      pvalue=0.05,
                      name='test'){
  # 1.挑选显著变化基因
  updown <- res[which(abs(res[,c("log2FoldChange")]) > log2FoldChange & res[,c("pvalue")] < pvalue),]

  # 2.挑选显著上调基因
  up <- res[which(res[,c("log2FoldChange")] > log2FoldChange & res[,c("pvalue")] < pvalue),]

  # 3.挑选显著下调基因
  down <- res[which(res[,c("log2FoldChange")] < -log2FoldChange & res[,c("pvalue")] < pvalue),]

  # 4.写出文件到当前目录
  write.csv(updown,file = paste(name,'updown.csv',sep = '_'),row.names = F)
  write.csv(up,file = paste(name,'up.csv',sep = '_'),row.names = F)
  write.csv(down,file = paste(name,'down.csv',sep = '_'),row.names = F)
}

