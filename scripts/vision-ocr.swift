import Foundation
import Vision
import AppKit
struct Word: Codable { let text:String; let x:Double; let y:Double; let w:Double; let h:Double; let confidence:Double }
struct Page: Codable { let page:Int; let width:Int; let height:Int; let words:[Word] }
let urls = CommandLine.arguments.dropFirst().dropLast().map{URL(fileURLWithPath:$0)}
var pages:[Page]=[]
for (idx,url) in urls.enumerated() {
 let image=NSImage(contentsOf:url)!; var rect=CGRect(origin:.zero,size:image.size); let cg=image.cgImage(forProposedRect:&rect,context:nil,hints:nil)!
 let req=VNRecognizeTextRequest(); req.recognitionLevel = .accurate; req.usesLanguageCorrection=true; req.recognitionLanguages=["en-US","en-GB"]
 try VNImageRequestHandler(cgImage:cg).perform([req]); var words:[Word]=[]
 for obs in req.results ?? [] {
  guard let s=obs.topCandidates(1).first?.string else {continue}; let pieces=s.split(whereSeparator:{$0.isWhitespace}); guard !pieces.isEmpty else{continue}
  let b=obs.boundingBox; let total=Double(pieces.reduce(0){$0+$1.count}) + Double(max(0,pieces.count-1))*0.45
  var pos=0.0
  for p in pieces {let ratio=Double(p.count)/total; words.append(Word(text:String(p),x:b.minX+pos*b.width,y:1-b.maxY,w:max(0.004,ratio*b.width),h:b.height,confidence:Double(obs.topCandidates(1).first!.confidence)));pos += ratio+0.45/total}
 }
 pages.append(Page(page:idx+7,width:cg.width,height:cg.height,words:words))
 NSLog("OCR page \(idx+7): \(words.count) tokens")
}
let enc=JSONEncoder();enc.outputFormatting=[.prettyPrinted,.sortedKeys];let data=try enc.encode(pages);try data.write(to:URL(fileURLWithPath:CommandLine.arguments.last!))
