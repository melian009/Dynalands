library(animation)
library(ncdf4)

getcolor<-function(x){
	if(x< -4500){col="blue"}
	else if((x > -4500)&(x< -3000)){col="lightblue"} 
	else if((x > -3000)&(x< -1500)){col="cyan"} 
	else if((x > -1500)&(x< 0)){col="lightgreen"} 
	else if((x > 0)&(x< 1000)){col="green"} 
	else if((x > 1000)&(x< 2000)){col="yellow"} 
	else if(x >=2000){col="brown"}

	return(col)
}

files<-c("000_138Ma_final.nc","001_137Ma_final.nc","002_136Ma_final.nc","003_135Ma_final.nc","004_134Ma_final.nc","005_133Ma_final.nc","006_132Ma_final.nc","007_131Ma_final.nc","008_130Ma_final.nc","009_129Ma_final.nc","010_128Ma_final.nc","011_127Ma_final.nc","012_126Ma_final.nc","013_125Ma_final.nc","014_124Ma_final.nc","015_123Ma_final.nc","016_122Ma_final.nc","017_121Ma_final.nc","018_120Ma_final.nc","019_119Ma_final.nc","020_118Ma_final.nc","021_117Ma_final.nc","022_116Ma_final.nc","023_115Ma_final.nc","024_114Ma_final.nc","025_113Ma_final.nc","026_112Ma_final.nc","027_111Ma_final.nc","028_110Ma_final.nc","029_109Ma_final.nc","030_108Ma_final.nc","031_107Ma_final.nc","032_106Ma_final.nc","033_105Ma_final.nc","034_104Ma_final.nc","035_103Ma_final.nc","036_102Ma_final.nc","037_101Ma_final.nc","038_100Ma_final.nc","039_99Ma_final.nc","040_98Ma_final.nc","041_97Ma_final.nc","042_96Ma_final.nc","043_95Ma_final.nc","044_94Ma_final.nc","045_93Ma_final.nc","046_92Ma_final.nc","047_91Ma_final.nc","048_90Ma_final.nc","049_89Ma_final.nc","050_88Ma_final.nc","051_87Ma_final.nc","052_86Ma_final.nc","053_85Ma_final.nc","054_84Ma_final.nc","055_83Ma_final.nc","056_82Ma_final.nc","057_81Ma_final.nc","058_80Ma_final.nc","059_79Ma_final.nc","060_78Ma_final.nc","061_77Ma_final.nc","062_76Ma_final.nc","063_75Ma_final.nc","064_74Ma_final.nc","065_73Ma_final.nc","066_72Ma_final.nc","067_71Ma_final.nc","068_70Ma_final.nc","069_69Ma_final.nc","070_68Ma_final.nc","071_67Ma_final.nc","072_66Ma_final.nc","073_65Ma_final.nc","074_64Ma_final.nc","075_63Ma_final.nc","076_62Ma_final.nc","077_61Ma_final.nc","078_60Ma_final.nc","079_59Ma_final.nc","080_58Ma_final.nc","081_57Ma_final.nc","082_56Ma_final.nc","083_55Ma_final.nc","084_54Ma_final.nc","085_53Ma_final.nc","086_52Ma_final.nc","087_51Ma_final.nc","088_50Ma_final.nc","089_49Ma_final.nc","090_48Ma_final.nc","091_47Ma_final.nc","092_46Ma_final.nc","093_45Ma_final.nc","094_44Ma_final.nc","095_43Ma_final.nc","096_42Ma_final.nc","097_41Ma_final.nc","098_40Ma_final.nc","099_39Ma_final.nc","100_38Ma_final.nc","101_37Ma_final.nc","102_36Ma_final.nc","103_35Ma_final.nc","104_34Ma_final.nc","105_33Ma_final.nc","106_32Ma_final.nc","107_31Ma_final.nc","108_30Ma_final.nc","109_29Ma_final.nc","110_28Ma_final.nc","111_27Ma_final.nc","112_26Ma_final.nc","113_25Ma_final.nc","114_24Ma_final.nc","115_23Ma_final.nc","116_22Ma_final.nc","117_21Ma_final.nc","118_20Ma_final.nc","119_19Ma_final.nc","120_18Ma_final.nc","121_17Ma_final.nc","122_16Ma_final.nc","123_15Ma_final.nc","124_14Ma_final.nc","125_13Ma_final.nc","126_12Ma_final.nc","128_10Ma_final.nc","129_9Ma_final.nc","130_8Ma_final.nc","131_7Ma_final.nc","132_6Ma_final.nc","133_5Ma_final.nc","134_4Ma_final.nc","135_3Ma_final.nc","136_2Ma_final.nc","137_1Ma_final.nc")

ani.options(outdir =   getwd());

saveGIF({
for(i in 1:length(files)){
	nc<-nc_open(files[i])
	var<-ncvar_get(nc)
	longitude=seq(from=-180,to=180,length.out=361)
	latitude=seq(from=-90,to=90,length.out=181)
	grid<-expand.grid(x=longitude,y=latitude)
	time<-as.character(unlist(strsplit(files[i],split="_")))[2]
	
	plot(grid,col=sapply(var,getcolor),ylim=c(-180,180),xlim=c(-90,90),xlab="Longitude",ylab="Latitude",main=time);}
}, movie.name = "./animation_ContDrift.gif", interval = 0.1, ani.width = 600, ani.height = 600)

