//
//  PlayerPayload.swift
//  bitmovin_sdk
//
//  Created by Vijae Manlapaz on 4/26/23.
//

import Foundation

class PlayerPayload {
	var id: Int?
	var data: Any?

	init() {}

	init(id: Int, data: Any?) {
		self.id = id
		self.data = data
	}
}
