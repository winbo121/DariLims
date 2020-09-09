// codebase �� cab ������ ��δ� �ý���(���)�� ������ ��ġ(URL)�� �����ؼ� ���.
// cab ������ ��ǰ�Ǵ� ��ǰ CD�� CAB ����� ������, ���� ����� �ִ� rdviewer.htm ���� ���� ������ Ȯ���ϰ� �����Ͽ� ����� ��.
// rdviewer50.cab�� �ʼ��̸�, �ٸ� control�� �ʿ� ���ο� ��� �ɼ����� ���
// OBJECT ���Ǵ� �ݵ�� rdviewer50.cab�� �������̾�� ��.

// MS XML Parser - XML �����͸� ����ϴ� ��� (Windows �⺻ ������Ʈ. �̼�ġ�� PC ������)
document.write('<object id=msxml4');
document.write('   classid="clsid:88d969c0-f192-11d4-a65f-0040963251e5"');
document.write('   codebase="../../cab/msxml4.cab#version=4,20,9818,0"');
document.write('   name=msxml4 width=0% height=0%>');
document.write('</OBJECT>');

// PDF Export Module
document.write('<object id=rdpdf50');
document.write('   classid="clsid:0D0862D3-F678-48B5-876B-456457E668BC"');
document.write('   codebase="../../cab/rdpdf50.cab#version=2,1,0,18"');
document.write('   width=0% height=0%>');
document.write('</OBJECT>');

// Barcode Control
document.write('<object id=rdbarcode5');
document.write('   classid="CLSID:AA30E61C-DBC4-4DF6-B2CC-FAE39282CF56"');
document.write('   codebase="../../cab/rdbarcode5.cab#version=5,5,0,50"');
document.write('   name=rdbarcode width=0% height=0%>');
document.write('</object>');

// Chart Control
document.write('<object id=TChart');
document.write('   classid="CLSID:FAB9B41C-87D6-474D-AB7E-F07D78F2422E"');
document.write('   codebase="../../cab/teechart7.cab#version=7,0,1,4"');
document.write('   name=TChart width=0% height=0%>');
document.write('</object>');

// Report Designer ActiveX Control (width, height�� ȭ�� ũ�⿡ �°� ����)
document.write('<OBJECT id=rdViewer ');
document.write('   classid="clsid:5A7B56B3-603D-4953-9909-1247D41967F8"');
document.write('  codebase="/cab/rdviewer50u.cab#version=5,0,0,100"');
document.write('      name=rdViewer width=100% height=100%>');
document.write('</OBJECT>');