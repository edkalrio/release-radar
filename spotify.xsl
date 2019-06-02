<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom">

	<xsl:template match="/">
		<html>
			<head>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
				<meta name="theme-color" content="#222"/>
				<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
				<title><xsl:value-of select="/atom:feed/atom:title"/></title>
				<style>
					html {
						font-size: 16px;
						font-family: sans-serif;
					}

					body {
						max-width: 500px;
						margin: auto;
						line-height: 1.5;
						color: #aaa;
						background-color: #111;
					}
						
					img {
						max-width: 100%;
						height: auto;
					}

					h1 {
						margin: 0 0 0.5rem;
						text-align: center;
						font-size: 2.5rem;
						line-height: 1.2;
						color: mediumseagreen; 
					}
					
					h3 {
						font-size: 1rem;						
						margin: .5rem 1rem 0 1rem;					
					}
					
					p {
						margin: 0 1rem;					
					}

					div {
						margin: 0;
						padding: 0 0 0.5rem;			
						font-size: 1rem;
						background-color: #222;
					}
					
					a {
						text-decoration: none;
						color: inherit;
					}
				</style>
			</head>
			<body>
				<xsl:apply-templates select="/atom:feed"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/atom:feed">
		<h1>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:value-of select="atom:link/@href"/>
				</xsl:attribute>
				<xsl:value-of select="atom:title"/>
			</xsl:element>
		</h1>
	
		<xsl:apply-templates select="atom:entry"/>
	</xsl:template>

	<xsl:template match="atom:entry">
		<xsl:for-each select=".">
			<div>
				<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:value-of select="atom:link/@href"/>
					</xsl:attribute>
					<xsl:value-of select="atom:content" disable-output-escaping="yes"/>
				</xsl:element>
				
				<h3>
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="atom:author/atom:uri"/>
						</xsl:attribute>
						<xsl:value-of select="atom:title" disable-output-escaping="yes"/>
					</xsl:element>
				</h3>
				
				<p>	
					<xsl:apply-templates select="atom:author"/>
					<!-- <date>
						<xsl:value-of select="atom:updated"/>
					</date> -->
				</p>	
			</div>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="atom:author">
		<xsl:for-each select=".">
			<span>
				<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:value-of select="atom:uri"/>
					</xsl:attribute>
					<xsl:value-of select="atom:name"/>
				</xsl:element>
			</span>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
